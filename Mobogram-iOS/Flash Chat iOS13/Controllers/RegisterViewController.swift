//
//  RegisterViewController.swift
//  Mobogram iOS
//
//  Created by Hamed Tara on 10/01/2024.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text,let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password){ authResult,error in
                
                if let e = error {
                    print (e.localizedDescription)
                    
                }else {
                    self.performSegue(withIdentifier: K.registerSegue , sender: self)
                }
                
            }
        }
    }
    
}
