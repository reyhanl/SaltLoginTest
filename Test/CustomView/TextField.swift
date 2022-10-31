//
//  TextField.swift
//  Test
//
//  Created by Reyhan on 31/10/22.
//

import UIKit

class TextField: UIView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var labelCenterYConstraint: NSLayoutConstraint!
    @IBInspectable var placeHolder: String? {
        didSet { label.text = placeHolder }
    }
    @IBInspectable var isSecureTextEntry: Bool = false{
        didSet { textField.isSecureTextEntry = isSecureTextEntry }
    }
    var text: String{
        return textField.text ?? ""
    }
    var delegate: TextFieldDelegate!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let nibName = String(describing: TextField.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setupUI(){
        textField.borderStyle = .none
        textField.delegate = self
    }
    
}

extension TextField: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        labelCenterYConstraint.constant = -(frame.height / 2)
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            labelCenterYConstraint.constant = 0
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.layoutIfNeeded()
            }
        }else{
            labelCenterYConstraint.constant = -(frame.height / 2)
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.layoutIfNeeded()
            }
        }
        delegate?.textFieldShouldReturn(self)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            labelCenterYConstraint.constant = 0
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.layoutIfNeeded()
            }
        }else{
            labelCenterYConstraint.constant = -(frame.height / 2)
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.layoutIfNeeded()
            }
        }
    }
}

protocol TextFieldDelegate{
    func textFieldShouldReturn(_ textField: TextField)
}
