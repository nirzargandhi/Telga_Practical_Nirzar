//
//  LaunchVC.swift
//  Telga_Practical_Nirzar
//
//  Created by Nirzar Gandhi on 04/08/21.
//

class LaunchVC: UIViewController {

    //MARK: - Outlet UIImageView
    @IBOutlet weak var imgvLogo: UIImageView!
    
    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()

        hideNavigationBar()
        
        imgvLogo.image = UIImage.gif(name: "logo_animated")
        
        self.perform(#selector(navigateToLoginVC), with: nil, afterDelay: 5.0)
    }
    
    //MARK: - Navigate To LoginVC Method
    @objc func navigateToLoginVC() {
       Utility().setRootLoginVC()
    }
}
