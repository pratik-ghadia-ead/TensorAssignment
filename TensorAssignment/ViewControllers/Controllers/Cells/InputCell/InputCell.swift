//
//  InputCell.swift
//  SKKit
//
//  Created by EAD on 10/10/23.
//

import UIKit

class InputCell: UITableViewCell {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var txtf: UITextField!
    
    weak var parentVC: UIViewController?
    var  fType: FormType = .login
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
// MARK:- UI Methods
extension InputCell{
    
    func prepareToFillData(_ userData: UserDataSpecifier, indexPath: IndexPath){
       fType = userData.fType
        let field = userData.allFields[indexPath.row]
        lblTitle.text = field.title
        txtf.placeholder = field.placeholder
        txtf.text = field.text
        self.tag = indexPath.row
        txtf.tag = indexPath.row

        txtf.autocorrectionType = .no
        txtf.autocapitalizationType = .none
        txtf.isSecureTextEntry = false
        txtf.keyboardType = .asciiCapable
        txtf.returnKeyType = .next
        
        
        if fType == .login {
            switch indexPath.row {
            case 0:
                txtf.keyboardType = .emailAddress
                break
            case 1:
                txtf.isSecureTextEntry = true
                txtf.returnKeyType = .done
                break
            default:
                break
            }
        }else {
            switch indexPath.row {
            case 1:
                txtf.keyboardType = .emailAddress
                break
            case 2, 3:
                txtf.isSecureTextEntry = true
                break
            case 5:
                txtf.returnKeyType = .done
                break
            default:
                break
            }
        }
    }
}
// MARK:- Actions
extension InputCell{
    @IBAction func txtfDidChangeAction(_ sender: UITextField){
        if let vc = parentVC as? LoginVC {
            vc.formData.allFields[sender.tag].text = sender.text!
        }else if let vc = parentVC as? RegisterVC {
            vc.formData.allFields[sender.tag].text = sender.text!
        }
    }
}
