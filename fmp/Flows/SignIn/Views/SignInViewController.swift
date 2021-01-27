//
//  SignInViewController.swift
//  fmp
//
//  Created by Stephen Parker on 25/1/2021.
//

import UIKit

class SignInViewController: UIViewController, Storyboarded {
    
    var viewModel: SignInViewModel?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        signIn(username: usernameTextField.text, password: passwordTextField.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel?.clearUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func validate(input: String?) -> Bool {
        return viewModel!.validate(string: input)
    }
    
    func signIn(username: String?, password: String?) {
        if validate(input: username) && validate(input: password) == true {
            guard let username = username, let password = password else {
                fatalError("impossible given validation wouldn't pass in this case")
            }
            viewModel?.signIn(with: username, password: password)
        }
        
    }


}

