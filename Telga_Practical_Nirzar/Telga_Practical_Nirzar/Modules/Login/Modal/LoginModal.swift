//
//  LoginModal.swift
//  Telga_Practical_Nirzar
//
//  Created by Nirzar Gandhi on 04/08/21.
//

struct LoginModal : Codable {
    let success : Int?
    let message : String?
    let data : LoginData?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Int.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
    }
}

struct LoginData : Codable {
    let token : String?
    let type : String?
    let expires_in : Int?
    let user : User?

    enum CodingKeys: String, CodingKey {

        case token = "token"
        case type = "type"
        case expires_in = "expires_in"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        expires_in = try values.decodeIfPresent(Int.self, forKey: .expires_in)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }
}

struct User : Codable {
    let id : Int?
    let username : String?
    let firstname : String?
    let lastname : String?
    let houseno : String?
    let address1 : String?
    let address2 : String?
    let city : String?
    let state : String?
    let country : String?
    let zip : String?
    let email : String?
    let mobile : String?
    let mobile1 : String?
    let homephone : String?
    let designation : String?
    let remark : String?
    let userrights : String?
    let emailrights : String?
    let usertype : Int?
    let clientid : String?
    let lastlogin : String?
    let timezone : Double?
    let profile_pic : String?
    let status : Int?
    let apikey : String?
    let is_dst : Int?
    let extra_users : String?
    let edit_history : String?
    let latitude : String?
    let longitude : String?
    let emergencywork : String?
    let device_id : String?
    let uuid : String?
    let new_password_encryption : Int?
    let reset_password_otp : Int?
    let reset_password_requested_date_time : String?
    let reset_password_token : String?
    let created_at : String?
    let updated_at : String?
    let deleted_at : String?
    let link : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case username = "username"
        case firstname = "firstname"
        case lastname = "lastname"
        case houseno = "houseno"
        case address1 = "address1"
        case address2 = "address2"
        case city = "city"
        case state = "state"
        case country = "country"
        case zip = "zip"
        case email = "email"
        case mobile = "mobile"
        case mobile1 = "mobile1"
        case homephone = "homephone"
        case designation = "designation"
        case remark = "remark"
        case userrights = "userrights"
        case emailrights = "emailrights"
        case usertype = "usertype"
        case clientid = "clientid"
        case lastlogin = "lastlogin"
        case timezone = "timezone"
        case profile_pic = "profile_pic"
        case status = "status"
        case apikey = "apikey"
        case is_dst = "is_dst"
        case extra_users = "extra_users"
        case edit_history = "edit_history"
        case latitude = "latitude"
        case longitude = "longitude"
        case emergencywork = "emergencywork"
        case device_id = "device_id"
        case uuid = "uuid"
        case new_password_encryption = "new_password_encryption"
        case reset_password_otp = "reset_password_otp"
        case reset_password_requested_date_time = "reset_password_requested_date_time"
        case reset_password_token = "reset_password_token"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case deleted_at = "deleted_at"
        case link = "link"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        firstname = try values.decodeIfPresent(String.self, forKey: .firstname)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        houseno = try values.decodeIfPresent(String.self, forKey: .houseno)
        address1 = try values.decodeIfPresent(String.self, forKey: .address1)
        address2 = try values.decodeIfPresent(String.self, forKey: .address2)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        mobile1 = try values.decodeIfPresent(String.self, forKey: .mobile1)
        homephone = try values.decodeIfPresent(String.self, forKey: .homephone)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        remark = try values.decodeIfPresent(String.self, forKey: .remark)
        userrights = try values.decodeIfPresent(String.self, forKey: .userrights)
        emailrights = try values.decodeIfPresent(String.self, forKey: .emailrights)
        usertype = try values.decodeIfPresent(Int.self, forKey: .usertype)
        clientid = try values.decodeIfPresent(String.self, forKey: .clientid)
        lastlogin = try values.decodeIfPresent(String.self, forKey: .lastlogin)
        timezone = try values.decodeIfPresent(Double.self, forKey: .timezone)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        apikey = try values.decodeIfPresent(String.self, forKey: .apikey)
        is_dst = try values.decodeIfPresent(Int.self, forKey: .is_dst)
        extra_users = try values.decodeIfPresent(String.self, forKey: .extra_users)
        edit_history = try values.decodeIfPresent(String.self, forKey: .edit_history)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        emergencywork = try values.decodeIfPresent(String.self, forKey: .emergencywork)
        device_id = try values.decodeIfPresent(String.self, forKey: .device_id)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        new_password_encryption = try values.decodeIfPresent(Int.self, forKey: .new_password_encryption)
        reset_password_otp = try values.decodeIfPresent(Int.self, forKey: .reset_password_otp)
        reset_password_requested_date_time = try values.decodeIfPresent(String.self, forKey: .reset_password_requested_date_time)
        reset_password_token = try values.decodeIfPresent(String.self, forKey: .reset_password_token)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        deleted_at = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        link = try values.decodeIfPresent(String.self, forKey: .link)
    }
}
