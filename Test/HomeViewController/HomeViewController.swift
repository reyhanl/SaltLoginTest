//
//  HomeViewController.swift
//  Test
//
//  Created by Reyhan on 31/10/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    
    var viewModel = HomeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewModelObserver()
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        guard let user = viewModel.user else{return}
        DispatchQueue.main.async {
            self.emailLabel.text = user.email
            self.firstNameLabel.text = user.firstName
            self.lastNameLabel.text = user.lastName
            self.tokenLabel.text = "token: \(self.viewModel.token ?? "")"
        }
    }

}

extension HomeViewController{
    func prepareViewModelObserver(){
        self.viewModel.fetchUserStatus = { success, error in
            if success{
                self.updateUI()
            }else{
                guard let error = error else{return}
                self.displayAlert(error: error)
            }
        }
        
        self.viewModel.downloadProfilePictureStatus = { success, error in
            if success{
                guard let image = self.viewModel.profilePicture else{return}
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        
        viewModel.getUser()
    }
    
    func displayAlert(error: String){
        var alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
