//
//  LoginViewController.swift
//  Mobogram iOS
//
//  Created by Hamed Tara on 10/01/2024.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print(e.localizedDescription)
                    } else {
                        // No error, perform the segue to the ChatVC
                        self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    }
                }
            }
    }
    
}
