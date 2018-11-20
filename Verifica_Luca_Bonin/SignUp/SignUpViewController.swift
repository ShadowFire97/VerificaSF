//
//  SignUpViewController.swift
//  Verifica_Luca_Bonin
//
//  Created by Leo Luca Bonin on 20/11/2018.
//  Copyright © 2018 developer.llb. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    var user : User?
    
    @IBOutlet weak var signUpLabel: UILabel!{
        didSet{
            signUpLabel.text = R.string.localizable.signUpLabel()
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            emailTextField.placeholder = R.string.localizable.emailPlaceHolder()
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.placeholder = R.string.localizable.passwordPlaceHolder()
        }
    }
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!{
        didSet{
            confirmPasswordTextField.placeholder = R.string.localizable.confirmPasswordPlaceHolder()
        }
    }
    
    @IBOutlet weak var signUpButton: UIButton!{
        didSet{
            signUpButton.setTitle(R.string.localizable.signUpLabel(), for: .normal)
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            loginButton.setTitle(R.string.localizable.loginLabel(), for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUpAction(_ sender: Any) {
        NetworkManager.signup(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: { success in
            print("success = \(success)")
            if success {
                self.user = User(email: self.emailTextField.text ?? "")
                self.performSegue(withIdentifier:
                    R.segue.signUpViewController.addDetailSegue, sender: self)
                
            }
        })
    }
    
    @IBAction func loginAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? AddInfoViewController {
            destinationController.user = user
        }
    }

}
