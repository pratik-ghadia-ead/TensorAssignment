//
//  ProfileImageCell.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import UIKit

class ProfileImageCell: UITableViewCell {
    @IBOutlet var imgView: UIImageView!
    
    weak var parentVC: UIViewController?
    var  fType: FormType = .login
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = 50
        imgView.layer.masksToBounds = true
    }
    
    func prepareToFillData(_ userData: UserDataSpecifier, indexPath: IndexPath){
        fType = userData.fType
        let field = userData.allFields[indexPath.row]
        imgView.image = field.pickedImg
    }
}

// MARK:- Actions
extension ProfileImageCell{
    @IBAction func btnChooseImageTapped(_ sender: UIButton){
        if let vc = parentVC as? RegisterVC{
            vc.chooseImageTapped()
        }
    }
}
