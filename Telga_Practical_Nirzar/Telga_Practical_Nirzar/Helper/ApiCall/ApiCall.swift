//
//  ApiCall.swift
//  ApiCallWithDecodable
//
//  Created by Nirzar on 12/06/18.
//  Copyright © 2018 Nirzar. All rights reserved.
//


class ApiCall: NSObject {
    
    let constValueField = "application/json"
    let constHeaderField = "Content-Type"
    
    func post<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: "POST", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func put<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl:apiUrl, params: requestPARAMS as [String : AnyObject], method: "PUT",model: model , isLoader : isLoader, isErrorToast : isErrorToast, completion: completion)
    }
    
    func get<T : Decodable>(apiUrl : String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestGetMethod(apiUrl: apiUrl, method: "GET", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func delete<T : Decodable>(apiUrl : String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestDeleteMethod(apiUrl: apiUrl, method: "DELETE", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func requestMethod<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: NSString, model: T.Type ,isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        request.httpMethod = method as String
        request.setValue(constValueField, forHTTPHeaderField: constHeaderField)
        
        if isAPIToken, let strToken : String = KeychainWrapper.standard.string(forKey: UserDefault.kAPIToken) {
            request.addValue("Bearer " + strToken, forHTTPHeaderField: "Authorization")
        }
        
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                
                let dictResponse = try decoder.decode(GeneralResponseModal.self, from: data)
                
                let code = dictResponse.success ?? 0
                
                if code == 1 {
                    let dictResponsee = try decoder.decode(model, from: data)
                    mainThread {
                        completion(true, dictResponsee as AnyObject)
                    }
                } else if code == 401 {
                    logOutMethod()
                } else {
                    mainThread {
                        completion(false, dictResponse.message as AnyObject)
                    }
                }
                
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
    
    func requestGetMethod<T : Decodable>(apiUrl : String, method: String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        request.httpMethod = method
        request.addValue(constValueField, forHTTPHeaderField: constHeaderField)
        
        if isAPIToken, let strToken : String = KeychainWrapper.standard.string(forKey: UserDefault.kAPIToken) {
            request.addValue("Bearer " + strToken, forHTTPHeaderField: "Authorization")
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                
                let dictResponse = try decoder.decode(GeneralResponseModal.self, from: data)
                
                let code = dictResponse.success ?? 0
                
                if code == 1 {
                    let dictResponsee = try decoder.decode(model, from: data)
                    mainThread {
                        completion(true, dictResponsee as AnyObject)
                    }
                } else if code == 401 {
                    logOutMethod()
                } else {
                    mainThread {
                        completion(false, dictResponse.message as AnyObject)
                    }
                }
                
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
    
    func requestDeleteMethod<T : Decodable>(apiUrl : String, method: String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        request.httpMethod = method
        
        if isAPIToken, let apiToken : String = KeychainWrapper.standard.string(forKey: UserDefault.kAPIToken) {
            request.setValue("Bearer " + apiToken, forHTTPHeaderField: "Authorization")
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                let dictResponse = try decoder.decode(GeneralResponseModal.self, from: data )
                
                let code = dictResponse.success ?? 0
                
                if code == 1 {
                    let dictResponsee = try decoder.decode(model, from: data)
                    mainThread {
                        completion(true, dictResponsee as AnyObject)
                    }
                } else if code == 401 {
                    logOutMethod()
                } else {
                    mainThread {
                        completion(false, dictResponse.message as AnyObject)
                    }
                }
                
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
}

//MARK: - Model Class
class GeneralResponseModal : Codable {
    let success : Int?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case message = "message"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Int.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
