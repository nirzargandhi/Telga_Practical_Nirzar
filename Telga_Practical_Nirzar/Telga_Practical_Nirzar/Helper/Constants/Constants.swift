//
//  Utility.swift


//MARK: - Colors
extension UIColor {
    
    class func appBlack1000() -> UIColor { return UIColor(named: "AppBlack1000")! }
    class func appBlack900() -> UIColor { return UIColor(named: "AppBlack900")! }
    class func appBlack800() -> UIColor { return UIColor(named: "AppBlack800")! }
    class func appBlack700() -> UIColor { return UIColor(named: "AppBlack700")! }
    class func appBlack600() -> UIColor { return UIColor(named: "AppBlack600")! }
    class func appBlack500() -> UIColor { return UIColor(named: "AppBlack500")! }
    class func appBlack400() -> UIColor { return UIColor(named: "AppBlack400")! }
    class func appError() -> UIColor { return UIColor(named: "AppError")! }
    class func appPlaceholder() -> UIColor { return UIColor(named: "AppPlaceholder")! }
    class func appPopUpBG() -> UIColor { return UIColor(named: "AppPopUpBG")! }
    class func appProfileBorder() -> UIColor { return UIColor(named: "AppProfileBorder")! }
    class func appProfileShadow() -> UIColor { return UIColor(named: "AppProfileShadow")! }
    class func appRed() -> UIColor { return UIColor(named: "AppRed")! }
}

// MARK: - Global
enum GlobalConstants {
    
    static let appName    = Bundle.main.infoDictionary!["CFBundleName"] as! String
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

//MARK: - StoryBoard Identifier's
enum AllStoryBoard {
    
    static let Main = UIStoryboard(name: "Main", bundle: nil)
}

//MARK: - ViewController Names
enum ViewControllerName {
    
    static let kLaunchVC = "LaunchVC"
    static let kLoginVC = "LoginVC"
    static let kForgotPasswordVC = "ForgotPasswordVC"
    static let kCheckMailVC = "CheckMailVC"
    static let kDashboardVC = "DashboardVC"
}

//MARK: - Cell Identifiers
enum CellIdentifiers {
    
}

//MARK: - Message's
enum AlertMessage {
    
    //In Progress Message
    static let msgInProgress = "In Progress"
    
    //Internet Connection Message
    static let msgNetworkConnection = "You are not connected to internet. Please connect and try again"
    
    //Camera, Images and ALbums Related Messages
    static let msgPhotoLibraryPermission = "Please enable access for photos from Privacy Settings"
    static let msgCameraPermission = "Please enable camera access from Privacy Settings"
    static let msgNoCamera = "Device has no camera"
    static let msgImageSaveIssue = "Photo is unable to save in your local storage. Please check storage or try after some time"
    static let msgSelectPhoto = "Please select photo"
    
    //Error
    static let msgError = "Something went wrong. Please try after sometime"
    
    //Validation Messages
    static let msgFullname = "Please enter full name"

    static let msgFirstname = "Please enter first name"
    static let msgLastname = "Please enter last name"
    
    static let msgEmail = "Please enter email address"
    static let msgValidEmail = "Please enter valid email address"
    
    static let msgPassword = "Please enter password"
    static let msgPasswordCharacter = "Password must contain atleast 8 characters and maximum 15 characters"
    
    static let msgCurrentPassword = "Please enter current password"
    static let msgCurrentPasswordCharacter = "Current password must contain atleast 8 characters and maximum 15 characters"
    
    static let msgNewPassword = "Please enter new password"
    static let msgNewPasswordCharacter = "New password must contain atleast 8 characters and maximum 15 characters"
    
    static let msgConfirmPassword = "Please enter confirm password"
    static let msgConfirmPasswordCharacter = "Confirm password must contain atleast 8 characters and maximum 15 characters"
    
    static let msgSearch = "Please enter search character"
    
    static let msgLeaveType = "Please select leave type"
    
    static let msgLeavePeriod = "Please select leave period"
    
    static let msgSelectStartDate = "Please select start date"
    static let msgSelectEndDate = "Please select end date"
    
    static let msgValidSelectionForEndDate = "Please change leave period"
    
    //General Delete Message
    static let msgGeneralDelete = "Are you sure you want to delete?"
    
    //Logout Message
    static let msgLogout = "Are you sure you want to log out from the application?"
}

//MARK: - Web Service URLs
enum WebServiceURL {
    
    //Local URL
    static let mainURL = ""
    
    static let LoginURL = mainURL + "login"
    static let ForgotPasswordURL = mainURL + "send-email"
}

//MARK: - Web Service Parameters
enum WebServiceParameter {
    
    static let pEmail = "email"
    static let pPassword = "password"
    static let pDevice_Id = "device_id"
}

//MARK: - UserDefault
enum UserDefault {
    
    static let kDeviceToken = "device_token"
    static let kEmailID = "email_id"
    static let kPassword = "password"
    static let kUserID = "userID"
    static let kFirstname = "firstname"
    static let kLastname = "lastname"
    static let kProfilePic = "profilepic"
    static let kAPIToken = "token"
    static let kScreenName = "screenname"
    static let kAPIParameter = "apiparameter"
    static let kIsKeyChain = "isKeyChain"
}

//MARK: - Constants
struct Constants {
    
    //MARK: - Device Type
    enum UIUserInterfaceIdiom : Int {
        
        case Unspecified
        case Phone
        case Pad
    }
    
    //MARK: - Screen Size
    struct ScreenSize {
        
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
}

//MARK: - DateTime Format
enum DateAndTimeFormatString {
    
    static let strDateFormate_ddMMyyyyhhmmss = "dd/MM/yyyy hh:mm a"
    static let strDateFormate_ddMMyyyy = "dd/MM/yyyy"
    static let strDateFormate_ddMMMyyyy = "dd MMM yyyy"
    static let strDateFormate_EEEddMMMyyyy = "EEE dd MMM yyyy"
    static let strDateFormate_yyyyMMdd = "yyyy-MM-dd"
    static let strTimeFormate_hhmma = "hh:mm a"
    static let strTimerFormate_mmss = "mm:ss"
    static let strDateFormate_EEEddMMM = "EEE, dd MMM"
}

