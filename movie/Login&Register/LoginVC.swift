//
//  LoginVC.swift
//  movie
//
//  Created by abdulla hmaher on 10/18/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import UIKit
import Firebase
class LoginVC: UIViewController {

    
    @IBOutlet var emailtxt: UITextField!
    @IBOutlet var passwordtxt: UITextField!


    @IBAction func login(_ sender: Any) {
        if self.emailtxt.text == "Admin@hotmail.com" && self.passwordtxt.text == "123456" {

        performSegue(withIdentifier: "toad", sender: self)
        } else {
            print("Can't login as Admin")
        }
    }
    
    @IBAction func LoginAsUser(_ sender: Any) {
        guard let email = emailtxt.text,
            let password = passwordtxt.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error signing in: \(error)")
            } else {
                self.performSegue(withIdentifier: "touser", sender: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tode" {
            let destVC = segue.destination as! movieTableCell
        }
    }*/
}
