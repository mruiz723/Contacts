//
//  Request.swift
//  ExampleAlamofirePUTDELETE
//
//  Created by Laura Mejia Arroyave on 2/23/16.
//  Copyright © 2016 NextU. All rights reserved.
//

import UIKit
import Alamofire

public typealias CompletionHandlerGET =  (_ success: Bool, _ response: [[String : AnyObject]]) ->()
public typealias CompletionHandlerPOST =  (_ success: Bool, _ response: [String : AnyObject]) ->()
public typealias CompletionHandlerPUTDELETE =  (_ success: Bool, _ response: [String : AnyObject]) ->()

let headers = [
    "Authorization": "Basic a2lkX1cxQmtMTUhEQ3g6ZWJiZjVhODg0MGIxNDg5NWFlOTg3YzM3MjIxZDE5NGE=",
    "Content-Type": "application/x-www-form-urlencoded"
]

class Request: NSObject{
    
    let url = "https://baas.kinvey.com/appdata/kid_W1BkLMHDCx/Contacts/"
    
    func getContacts(_ completion:@escaping CompletionHandlerGET){
        Alamofire.request(url, headers: headers)
            .responseJSON(){response in
                
                switch response.result {
                case .success(let JSON):
                    print("Llamado de GET \(JSON)")
                    completion(true, JSON as! [[String : AnyObject]])
                case .failure(let error):
                    completion(false, [["error":error.localizedDescription as AnyObject]])
                }
        }
    }
    
    func saveContact(_ parameters:[String: AnyObject], completion:@escaping CompletionHandlerPOST){
        Alamofire.request(url, method:.post, parameters:parameters, headers:headers)
            .responseJSON(){response in
            switch response.result {
            case .success(let JSON):
                completion(true, JSON as! [String : AnyObject])
            case .failure(let error):
                completion(false, ["error":error.localizedDescription as AnyObject])
            }
        }
    }
    
    func deleteContact(_ contactID: String, completion:@escaping CompletionHandlerPUTDELETE){
        
        let urlWithContact : String = "\(url)\(contactID)"
        
        Alamofire.request(urlWithContact, method:.delete, headers: headers)
            .responseJSON(){response in
                
                switch response.result {
                    
                case .success(let JSON):
                    
                    print("Borrado 1 contacto")
                    completion(true, ["response":JSON as AnyObject])
                    
                case .failure(let error):
                    
                    completion(false, ["error":error.localizedDescription  as AnyObject])
                }
        }
    }
    
    func updateContact(_ contactID: String, parameters: [String: AnyObject], completion:@escaping CompletionHandlerPUTDELETE){
        
        let urlWithContact : String = "\(url)\(contactID)"
        
        Alamofire.request(urlWithContact, method: .put, parameters: parameters, headers: headers)
            .responseJSON(){response in
                
                switch response.result {
                case .success(let JSON):
                    
                    print("Actualizado 1 contacto")
                    completion(true, ["response":JSON as AnyObject])
                    
                case .failure(let error):
                    
                    completion(false, ["error":error.localizedDescription as AnyObject])
                }
                
        }
    }
}
