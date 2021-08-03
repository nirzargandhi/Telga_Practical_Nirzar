//
//  LoginVC.swift
//  SmartWorkx
//
//  Created by Nirzar Gandhi on 20/07/21.
//

class LoginVC: UIViewController {
    
    //MARK: - UITextField Outlets
    @IBOutlet weak var txtEmailID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: - UILabel Outlets
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    
    //MARK: - UIButton Outlet
    @IBOutlet weak var btnShowPassword: UIButton!
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    //MARK: - Initialization Method
    func initialization() {
        
        hideNavigationBar()
        
        if let strEmailID : String = KeychainWrapper.standard.string(forKey: UserDefault.kEmailID),  let strPassword : String = KeychainWrapper.standard.string(forKey: UserDefault.kPassword) {
            
            txtEmailID.text = strEmailID
            txtPassword.text = strPassword
            
            wsLogin()
        }
    }
    
    //MARK: - UIButton Action Methods
    @IBAction func btnShowPasswordAction(_ sender: Any) {
        
        hideIQKeyboard()
        
        changeTextfieldHoverColor()
        
        hideErrorLabel()
        
        btnShowPassword.isSelected = !btnShowPassword.isSelected
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
    }
    
    @IBAction func btnForgotPasswordAction(_ sender: Any) {
        
        hideIQKeyboard()
        
        changeTextfieldHoverColor()
        
        hideErrorLabel()
        
        let objForgotPasswordVC = AllStoryBoard.Main.instantiateViewController(withIdentifier: ViewControllerName.kForgotPasswordVC)  as! ForgotPasswordVC
        self.navigationController?.pushViewController(objForgotPasswordVC, animated: true)
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        
        hideIQKeyboard()
        
        changeTextfieldHoverColor()
        
        hideErrorLabel()
        
        if txtEmailID.isEmpty {
            lblEmailError.text = AlertMessage.msgEmail
            lblEmailError.isHidden = false
        } else if !txtEmailID.validateEmail() {
            lblEmailError.text = AlertMessage.msgValidEmail
            lblEmailError.isHidden = false
        } else if txtPassword.isEmpty {
            lblPasswordError.text = AlertMessage.msgPassword
            lblPasswordError.isHidden = false
        }
        else if !txtPassword.checkMinAndMaxLength(withMinLimit: 8, withMaxLimit: 15) {
            lblPasswordError.text = AlertMessage.msgPasswordCharacter
            lblPasswordError.isHidden = false
        }
        else {
            KeychainWrapper.standard.set(self.txtEmailID.text ?? "", forKey: UserDefault.kEmailID)
            Utility().setRootDashboardVC()
        }
    }
    
    //MARK: - Change Textfield Hover Color Method
    func changeTextfieldHoverColor() {
        txtEmailID.borderColor = .appBlack500()
        txtPassword.borderColor = .appBlack500()
    }
    
    //MARK: - Hide Error Label Method
    func hideErrorLabel() {
        lblEmailError.text = ""
        lblPasswordError.text = ""
        
        lblEmailError.isHidden = true
        lblPasswordError.isHidden = true
    }
    
    //MARK: - Webservice Call Method
    func wsLogin() {
        
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.view.makeToast(AlertMessage.msgNetworkConnection)
            return
        }
        
        var params = [String : Any]()
        params [WebServiceParameter.pEmail] = txtEmailID.text ?? ""
        params [WebServiceParameter.pPassword] = txtPassword.text ?? ""
        
        if let deviceToken : String = KeychainWrapper.standard.string(forKey: UserDefault.kDeviceToken) {
            params [WebServiceParameter.pDevice_Id] = deviceToken
        } else {
            params [WebServiceParameter.pDevice_Id] = "7bdd29f99762b41f06be5473be83f83b6e4b24fce86334d8ac9f1682a883cb18"
        }
        
        ApiCall().post(apiUrl: WebServiceURL.LoginURL, requestPARAMS: params, model: LoginModal.self) { (success, responseData) in
            if success, let responseData = responseData as? LoginModal {
                
                KeychainWrapper.standard.set(responseData.data?.user?.id ?? 0, forKey: UserDefault.kUserID)
                KeychainWrapper.standard.set(self.txtEmailID.text ?? "", forKey: UserDefault.kEmailID)
                KeychainWrapper.standard.set(self.txtPassword.text ?? "", forKey: UserDefault.kPassword)
                KeychainWrapper.standard.set(responseData.data?.user?.firstname ?? "", forKey: UserDefault.kFirstname)
                KeychainWrapper.standard.set(responseData.data?.user?.lastname ?? "", forKey: UserDefault.kLastname)
                KeychainWrapper.standard.set(responseData.data?.user?.link ?? "", forKey: UserDefault.kProfilePic)
                KeychainWrapper.standard.set(responseData.data?.token ?? "", forKey: UserDefault.kAPIToken)
                
                setUserDefault(true, key: UserDefault.kIsKeyChain)
                
                Utility().setRootDashboardVC()
            } else {
                mainThread {
                    self.lblPasswordError.text = Utility().wsFailResponseMessage(responseData: responseData!)
                    self.lblPasswordError.isHidden = false
                }
            }
        }
    }
}

//MARK: - UITextFieldDelegate Extension
extension LoginVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        hideErrorLabel()
        
        if textField == txtEmailID {
            txtEmailID.borderColor = .appRed()
            txtPassword.borderColor = .appBlack500()
        } else {
            txtPassword.borderColor = .appRed()
            txtEmailID.borderColor = .appBlack500()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == UIReturnKeyType.next {
            textField.superview?.superview?.superview?.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
        } else if textField.returnKeyType == UIReturnKeyType.done {
            textField.resignFirstResponder()
            
            changeTextfieldHoverColor()
            
            hideErrorLabel()
        }
        
        return true
    }
}

