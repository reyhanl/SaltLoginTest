//
//  ViewController.swift
//  Test
//
//  Created by Reyhan on 31/10/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        prepareViewModelObserver()
    }

    @IBAction func login(_ sender: Any) {
        viewModel.login(username: emailTextField.text, password: passwordTextField.text)
    }
}

extension LoginViewController{
    
    func setupUI(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func prepareViewModelObserver(){
        self.viewModel.loginStatus = { success, error in
            if success{
                self.goToHomeViewController()
            }else{
                guard let error = error else{return}
                let alert = UIAlertController(title: "Login Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func goToHomeViewController(){
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
        }

    }
}

extension LoginViewController: TextFieldDelegate{
    func textFieldShouldReturn(_ textField: TextField) {
        if textField === emailTextField{
            self.passwordTextField.textField.becomeFirstResponder()
        }else{
            login(self)
        }
    }
    
    
}
