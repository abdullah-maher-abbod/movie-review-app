//
//  registerVC.swift
//  movie
//
//  Created by abdulla hmaher on 10/25/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import UIKit
import Firebase

class registerVC: UIViewController {

    @IBOutlet var UsernameField: UITextField!
    @IBOutlet var EmailField: UITextField!
    @IBOutlet var PasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerbtn(_ sender: Any) {
        guard let usename = UsernameField.text else {return}
        guard let email = EmailField.text else {return}
        guard let password = PasswordField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) {user, error in
            if error == nil && user != nil {
                print("user created!")
                self.dismiss(animated: true, completion: nil)
                
            }else{
                print("error to create a user: \(error?.localizedDescription)")
            }
        }
        
    }
    @IBAction func cancelbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
