//
//  LoginButtonCell.swift
//  TensorAssignment
//
//  Created by EAD on 09/10/23.
//

import UIKit

class LoginButtonCell: UITableViewCell {
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var stkViewOr: UIStackView!

    weak var parentVC: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK:- Actions
extension LoginButtonCell{
    @IBAction func btnLoginTapped(_ sender: UIButton){
        if let vc = parentVC as? LoginVC{
            vc.loginTapped()
        }
    }
    
    @IBAction func btnRegisterTapped(_ sender: UIButton){
        if let vc = parentVC as? LoginVC{
            vc.registerTapped()
        }else if let vc = parentVC as? RegisterVC{
            vc.registerTapped()
        }
    }
}
