//
//  CheckMailVC.swift
//  SmartWorkx
//
//  Created by Nirzar Gandhi on 21/07/21.
//

class CheckMailVC: UIViewController {
    
    //MARK: - Variable Declaration
    var strEmailID : String?
    
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
    @IBAction func btnOpenEmailAppAction(_ sender: Any) {
        if let emailURL = URL(string: "mailto:\(strEmailID ?? "")"), UIApplication.shared.canOpenURL(emailURL) {
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnSkipAction(_ sender: Any) {
        Utility().setRootLoginVC()
    }
    
    @IBAction func btnSendLinkAgainAction(_ sender: Any) {
        wsSendMailAgain()
    }
    
    //MARK: - Webservice Call Method
    func wsSendMailAgain() {
        
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.view.makeToast(AlertMessage.msgNetworkConnection)
            return
        }
        
        var params = [String : Any]()
        params [WebServiceParameter.pEmail] = strEmailID ?? ""
        
        ApiCall().post(apiUrl: WebServiceURL.ForgotPasswordURL, requestPARAMS: params, model: GeneralResponseModal.self) { (success, responseData) in
            if success, let responseData = responseData as? GeneralResponseModal {
                self.view.makeToast(responseData.message ?? "")
            } else {
                mainThread {
                    self.view.makeToast(Utility().wsFailResponseMessage(responseData: responseData!))
                }
            }
        }
    }
}
