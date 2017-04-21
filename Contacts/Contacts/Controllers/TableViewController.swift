//
//  TableViewController.swift
//  ExampleAlamofirePUTDELETE
//
//  Created by Laura Mejia Arroyave on 2/23/16.
//  Copyright © 2016 NextU. All rights reserved.
//

import UIKit
import Alamofire
class TableViewController: UITableViewController{
    var contact = Contact()
    var model: Contact = Contact()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadContactsOfRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.contactsAgenda.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let contactRow = self.model.contactsAgenda[indexPath.row]
        
        cell.nameLabel.text = contactRow.name
        cell.lastNameLabel.text = contactRow.lastName
        
        if let tel = contactRow.phone{
            cell.phoneLabel.text = "Tel: \(tel)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        contact = self.model.contactsAgenda[indexPath.row]
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Borrar" , handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
            
            let contactToDelete = self.model.contactsAgenda[indexPath.row]
            
            
            self.model.deleteContact(indexPath.row, contactID: contactToDelete.id!, completion: { (success, response) -> () in
                
                if success{
                    self.makeAlert("El contacto ha sido borrado", type: .default)
                    
                    self.tableView.reloadData()
                }else
                {
                    self.makeAlert("Ha ocurrido un error al borrar: \(response)", type: .default)
                }
            })
            
        })
        
        return [deleteAction]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ViewController{
            if segue.identifier == "detail" {
                destinationVC.model = self.model
                destinationVC.contact = contact
                destinationVC.identifierView = segue.identifier
            } else if segue.identifier == "add" {
                destinationVC.model = self.model
                destinationVC.identifierView = segue.identifier
            }
        }
    }
    
    func reloadContactsOfRequest(){
        print("ContactsOfRequest")
        self.model.getContacts { (success, response) -> () in
            self.self.model.contactsAgenda = response
            self.tableView.reloadData()
        }
    }
    
    func makeAlert(_ message: String, type: UIAlertActionStyle) {
        
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
