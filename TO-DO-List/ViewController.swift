//
//  ViewController.swift
//  TO-DO-List
//
//  Created by Manali Rami on 2018-09-23.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoLabel: UILabel!
    
}
class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var todoData = [String]()
    var ref : DatabaseReference!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "custom")
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("data").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value as? NSDictionary else {
                print("The user has no data in our database")
                return
            }
            let todoItems = value["todoItem"] as? [String]
            self.todoData = todoItems!
            self.tableView.reloadData()
            
            //.......
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addItem(_ sender: Any) {
        let alertController = UIAlertController(title: "Add an issue", message: "Please add your item to to-do list", preferredStyle: .alert)
        
        let enterAction = UIAlertAction(title:"Enter", style: .default, handler: {(_) in
        if let field = alertController.textFields![0] as? UITextField {
            self.todoData.append(field.text!)
            self.ref.child("data").child((Auth.auth().currentUser?.uid)!).setValue(["todoItem":self.todoData])
            self.tableView.reloadData() 
        }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_) in })
        
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "To-Do Item"
            
        })
        
        alertController.addAction(enterAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "custom") as!
            CustomTableViewCell
        cell.todoLabel.text = todoData[indexPath.row]
        return cell
    }
    
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "back", sender: self)
        } catch {
            print("No user is logged in")
        }
    }
    
}

