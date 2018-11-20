//
//  LoginViewController.swift
//  Verifica_Luca_Bonin
//
//  Created by Leo Luca Bonin on 20/11/2018.
//  Copyright © 2018 developer.llb. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //Outlet
    @IBOutlet weak var loginLabel: UILabel!{
        didSet{
            loginLabel.text = R.string.localizable.loginLabel()
        }
    }
    
    @IBOutlet weak var loginTextField: UITextField!{
        didSet{
            loginTextField.placeholder = R.string.localizable.emailPlaceHolder()
        }
    }
    
    @IBOutlet weak var passwordField: UITextField!{
        didSet{
            passwordField.placeholder = R.string.localizable.passwordPlaceHolder()
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            loginButton.setTitle(R.string.localizable.loginLabel(), for: .normal)
        }
    }
    
    @IBOutlet weak var signUpButton: UIButton!{
        didSet{
            signUpButton.setTitle(R.string.localizable.signUpLabel(), for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        NetworkManager.login(email: loginTextField.text ?? "", password: passwordField.text ?? "", completion: { success in
            if success {
                self.performSegue(withIdentifier: R.segue.loginViewController.toMainSegue, sender: self)}
        })
        
    }
    
}
