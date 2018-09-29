//
//  LogInViewController.swift
//  TO-DO-List
//
//  Created by Manali Rami on 2018-09-23.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func LogIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user,error) in
            if error == nil {
                self.performSegue(withIdentifier: "login", sender: self)
                
            }
        }
    }

}
