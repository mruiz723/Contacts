//
//  Contacts.swift
//  ExampleAlamofirePUTDELETE
//
//  Created by Laura Mejia Arroyave on 2/24/16.
//  Copyright © 2016 NextU. All rights reserved.
//

import UIKit

class Contact {
    
    
    typealias CompletionHandlerGET = (_ success: Bool, _ response: [Contact]) ->()
    
    let request: Request = Request()
    
    var contactsAgenda = [Contact]()
    
    //MARK: - Properties
    var id: String?
    var name: String?
    var lastName: String?
    var phone: String?
    var email: String?
    
    
    //MARK: - Init
    init(id: String, name:String, lastName:String, phone:String, email:String){
        self.id = id
        self.name = name
        self.lastName = lastName
        self.phone = phone
        self.email = email
    }
    
    convenience init(){
        
        self.init(id:"", name:"", lastName:"", phone:"", email:"")
        
    }
    
    func getContacts(_ completion: @escaping CompletionHandlerGET){
        
        request.getContacts { (success, response) -> () in
            
            if success{
                
                self.contactsAgenda.removeAll()
                
                for item in response{
                    
                    let contact = Contact(id: item["_id"] as? String ?? "",
                                        name: item["name"] as? String ?? "",
                                        lastName: item["last_name"] as? String ?? "",
                                        phone: item["phone"] as? String ?? "",
                                        email: item["email"] as? String ?? "")
                    
                    self.contactsAgenda.append(contact)
                }
                
                completion(true, self.contactsAgenda)
                
            }else{
                
                completion(false, self.contactsAgenda)
            }
            
        }
    }
    
    func saveContact(_ contact: Contact, completion:@escaping CompletionHandlerGET){
        let parameters : [String: AnyObject] = ["name": contact.name! as AnyObject, "last_name": contact.lastName! as AnyObject, "phone":contact.phone! as AnyObject, "email":contact.email! as AnyObject]
        
        request.saveContact(parameters) { (success, response) -> () in
            if success{
                self.contactsAgenda.append(contact)
                completion(true, self.contactsAgenda)
            }else{
                completion(false, self.contactsAgenda)
            }
            
        }
    }
    
    func deleteContact(_ index : Int, contactID: String, completion: @escaping CompletionHandlerGET){
        
        request.deleteContact(contactID) { (success, response) -> () in
            
            if success{
                
                self.contactsAgenda.remove(at: index)
                completion(true, self.contactsAgenda)
                
            }else{
                
                completion(false, self.contactsAgenda)
            }
            
        }
    }
    
    func updateContact(_ contact : Contact, completion: @escaping CompletionHandlerGET){
        
        
        let parameters : [String: AnyObject] = ["name": contact.name! as AnyObject, "last_name": contact.lastName! as AnyObject, "phone":contact.phone! as AnyObject, "email":contact.email! as AnyObject]
        
        request.updateContact(contact.id!, parameters: parameters) { (success, response) -> () in
            
            if success{
                
                for item in self.contactsAgenda{
                    
                    if item.id == contact.id!{
                        
                        item.name = contact.name
                        item.lastName = contact.lastName
                        item.phone = contact.phone
                        item.email = contact.email
                    }
                }
                
                completion(true, self.contactsAgenda)
                
            }else{
                
                completion(false, self.contactsAgenda)
            }
            
        }
    }
}

 
