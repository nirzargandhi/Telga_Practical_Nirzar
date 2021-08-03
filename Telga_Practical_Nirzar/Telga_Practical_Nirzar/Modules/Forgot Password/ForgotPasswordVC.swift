//
//  ForgotPasswordVC.swift
//  SmartWorkx
//
//  Created by Nirzar Gandhi on 21/07/21.
//

class ForgotPasswordVC: UIViewController {
    
    //MARK: - UITextField Outlet
    @IBOutlet weak var txtEmailID: UITextField!
    
    //MARK: - UIButton Outlet
    @IBOutlet weak var btnClear: UIButton!
    
    //MARK: - UILabel Outlet
    @IBOutlet weak var lblEmailError: UILabel!
    
    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    //MARK: - Initialization Method
    func initialization() {
        
        hideNavigationBar()
    }
    
    //MARK: - UIButton Action Methods
    @IBAction func btnBackAction(_ sender: Any) {
        
        hideIQKeyboard()
        
        changeTextfieldHoverColor()
        
        hideErrorLabel()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearAction(_ sender: Any) {
        
        hideIQKeyboard()
        
        changeTextfieldHoverColor()
        
        hideErrorLabel()
        
        txtEmailID.text = ""
        
        btnClear.isHidden = true
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
        } else {
            wsForgotPassword()
        }
    }
    
    //MARK: - Change Textfield Hover Color Method
    func changeTextfieldHoverColor() {
        txtEmailID.borderColor = .appBlack500()
    }
    
    //MARK: - Hide Error Label Method
    func hideErrorLabel() {
        lblEmailError.text = ""
        
        lblEmailError.isHidden = true
    }
    
    //MARK: - Webservice Call Method
    func wsForgotPassword() {
        
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.view.makeToast(AlertMessage.msgNetworkConnection)
            return
        }
        
        var params = [String : Any]()
        params [WebServiceParameter.pEmail] = txtEmailID.text ?? ""
        
        ApiCall().post(apiUrl: WebServiceURL.ForgotPasswordURL, requestPARAMS: params, model: GeneralResponseModal.self) { (success, responseData) in
            if success, let _ = responseData as? GeneralResponseModal {
                
                let objCheckMailVC = AllStoryBoard.Main.instantiateViewController(withIdentifier: ViewControllerName.kCheckMailVC)  as! CheckMailVC
                objCheckMailVC.strEmailID = self.txtEmailID.text ?? ""
                self.navigationController?.pushViewController(objCheckMailVC, animated: true)
                
            } else {
                mainThread {
                    self.lblEmailError.text = Utility().wsFailResponseMessage(responseData: responseData!)
                    self.lblEmailError.isHidden = false
                }
            }
        }
    }
}

//MARK: - UITextFieldDelegate Extension
extension ForgotPasswordVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        hideErrorLabel()
        
        if textField == txtEmailID {
            txtEmailID.borderColor = .appRed()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtEmailID && string.count > 0 {
            btnClear.isHidden = false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == UIReturnKeyType.next {
            textField.superview?.superview?.superview?.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
        } else if textField.returnKeyType == UIReturnKeyType.done {
            textField.resignFirstResponder()
        }
        
        changeTextfieldHoverColor()
        
        hideErrorLabel()
        
        return true
    }
}
