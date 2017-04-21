//
//  ViewController.swift
//  Contacts
//
//  Created by Alejocram on 25/02/16.
//  Copyright © 2016 NextU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var contact = Contact()
    
    var model:Contact!

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!

    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var putButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    var identifierView:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameTextField.text = contact.name
        self.lastNameTextField.text = contact.lastName
        self.phoneTextField.text = contact.phone
        self.emailTextField.text = contact.email
        
        if self.identifierView == "detail" {
            saveButton.isHidden = true
            
        } else if self.identifierView == "add" {
            saveButton.isHidden = false
            putButton.isHidden = true 
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveContact(_ sender: AnyObject) {
        let contact = Contact(id: "0", name: nameTextField.text!, lastName: lastNameTextField.text!, phone: phoneTextField.text!, email: emailTextField.text!)
        model.saveContact(contact) { (success, response) -> () in
            if success {
                self.makeAlert("El contacto ha sido guardado", type: .default)
            } else {
                self.makeAlert("Ha ocurrido un error al guardar el contacto: \(response)", type: .default)
            }
        }
    }
    
    @IBAction func makePUTButton(_ sender: AnyObject) {
        contact.name = self.nameTextField.text!
        contact.lastName = self.lastNameTextField.text!
        contact.phone = self.phoneTextField.text!
        contact.email = self.emailTextField.text!
        
        model.updateContact(contact) { (success, response) -> () in
            
            if success{
                self.makeAlert("El contacto ha sido actualizado", type: .default)
                
                self.model.contactsAgenda = response
            }else{
                self.makeAlert("Ha ocurrido un error al actualizar: \(response)", type: .default)
            }
        }
    }
    
    func makeAlert(_ message: String, type: UIAlertActionStyle) {
        
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            
           _ = self.navigationController?.popToRootViewController(animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
