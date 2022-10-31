//
//  LoginModel.swift
//  Test
//
//  Created by Reyhan on 31/10/22.
//

import Foundation

class LoginViewModel: LoginViewModelProtocol {
    //MARK: - Internal Properties
    
    var loginStatus: ((Bool, String?) -> Void)?
    
    var token: Token? {
        didSet {
            self.loginStatus!(true, nil)
            saveToken()
        }
    }
    
    func login(username: String, password: String) {
       
        
        Networking.shared.login(username: username, password: password){ result in
            switch result{
            case .success(let token):
                self.token = token
            case .failure(let error):
                self.loginStatus!(false, error.localizedDescription)
            }
        }
    }
    
    func saveToken(){
        guard let token = token?.token else{return}
        UserDefaults.standard.setValue(token, forKey: "token")
    }
    
}

protocol LoginViewModelProtocol {
    
    var loginStatus: ((Bool, String?) -> Void)? { get set }
    
    func login(username: String, password: String)
}
