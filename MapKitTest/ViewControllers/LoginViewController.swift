//
//  LoginViewController.swift
//  MapKitTest
//
//  Created by User on 20.01.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeButton()
    }
    
    func customizeButton() {
        loginOutlet.backgroundColor = .cyan
        loginOutlet.layer.cornerRadius = 15
        loginOutlet.layer.borderWidth = 1
        loginOutlet.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        checkTextField()
    }
    
    func checkTextField() {
        guard let mapVC = storyboard?.instantiateViewController(identifier: "MapViewController") as? MapViewController else { return }
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            guard let email = emailTextField.text else { return }
            mapVC.email = email
            navigationController?.pushViewController(mapVC, animated: true)
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "Enter your email and password", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                if let emailTF = alertController.textFields?[0] {
                    if let text = emailTF.text {
                        self.emailTextField.text = text
                    }
                }
                
                if let passTF = alertController.textFields?[1] {
                    passTF.placeholder = "Password"
                    if let text = passTF.text {
                        self.passwordTextField.text = text
                    }
                }
            }
            
            alertController.addAction(alertAction)
            alertController.addTextField { (emailTF) in
                emailTF.placeholder = "Email"
            }
            alertController.addTextField { (passTF) in
                passTF.placeholder = "Password"
            }
            self.present(alertController, animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

