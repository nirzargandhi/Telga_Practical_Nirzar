//
//  DashboardVC.swift
//  Telga_Practical_Nirzar
//
//  Created by Nirzar Gandhi on 04/08/21.
//

class DashboardVC: UIViewController {
    
    //MARK: - UILabel Outlet
    @IBOutlet weak var lblEmailID: UILabel!
    
    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    //MARK: - initialization Method
    func initialization() {
        
        hideNavigationBar()
        
        if let strEmailID : String = KeychainWrapper.standard.string(forKey: UserDefault.kEmailID) {
            
            lblEmailID.text = strEmailID
        }
    }
    
    //MARK: - UIButton Action Method
    @IBAction func btnShareAction(_ sender: Any) {
        
        let textToShare = String(describing: "\(lblEmailID.text ?? "") is inviting you join the app")
        
        guard let myAppURLToShare = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX"), let image = UIImage(named: "ic_message.png") else {
            return
        }
        let items = [textToShare, myAppURLToShare, image] as [Any]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        self.present(avc, animated: true, completion: nil)
    }
}
