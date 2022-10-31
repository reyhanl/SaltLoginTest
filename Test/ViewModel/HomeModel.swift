//
//  HomeModel.swift
//  Test
//
//  Created by Reyhan on 31/10/22.
//

import UIKit

class HomeModel: HomeModelProtocol {
    //MARK: - Internal Properties
    
    var fetchUserStatus: ((Bool, String?) -> Void)?
    var downloadProfilePictureStatus: ((Bool, String?) -> Void)?
    
    var token: String?{
        guard let token = UserDefaults.standard.string(forKey: "token") else{
            return nil
        }
        return token
    }
    
    var profilePicture: UIImage?{
        didSet{
            downloadProfilePictureStatus!(true, nil)
        }
    }
    var user: User? {
        didSet {
            downloadProfilePicture()
            self.fetchUserStatus!(true, nil)
        }
    }
    
    func getUser() {
        Networking.shared.getUser(completion: { result in
            switch result{
            case .success(let wrapper):
                self.user = wrapper.data
            case .failure(let error):
                self.fetchUserStatus!(false, error.localizedDescription)
            }
        })
    }
    
    func downloadProfilePicture(){
        guard let urlString = user?.avatar, let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                return
            }
            guard let data = data else{return}
            let image = UIImage(data: data)
            self.profilePicture = image
        }.resume()
    }
    
}

protocol HomeModelProtocol {
    
    var fetchUserStatus: ((Bool, String?) -> Void)? { get set }
    var downloadProfilePictureStatus: ((Bool, String?) -> Void)?{get set}
    
    func getUser()
}
