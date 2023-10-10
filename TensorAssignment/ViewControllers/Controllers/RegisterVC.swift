//
//  RegisterVC.swift
//  TensorAssignment
//
//  Created by EAD on 09/10/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Firebase
import FirebaseDatabase

public class RegisterVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var formData: UserDataSpecifier = UserDataSpecifier(.register)
    var imagePicker = UIImagePickerController()
    var ref: DatabaseReference!
    private let registerViewModel = RegisterViewModel()
    private let databaseViewModel = DatabaseViewModel()
    private var isImageUpload = false
    var profileImg = UIImage()
    private let imageUploadViewModel = UploadImageViewModel()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        let profileImageCellNib = UINib(nibName: "ProfileImageCell", bundle: nil)
        tableView.register(profileImageCellNib, forCellReuseIdentifier: "ProfileImageCell")

        let inputCellNib = UINib(nibName: "InputCell", bundle: nil)
        tableView.register(inputCellNib, forCellReuseIdentifier: "InputCell")

        let buttonCellNib = UINib(nibName: "LoginButtonCell", bundle: nil)
        tableView.register(buttonCellNib, forCellReuseIdentifier: "LoginButtonCell")

        // Set the data source and delegate for the table view
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    class func create() -> RegisterVC {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        return viewController
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Cell handler
extension RegisterVC {
    func registerTapped() {
        let data = formData.paramDictionaty()
        guard let email = data["email"], let password = data["password"], let confirmpassword = data["confirmPassword"], let username = data["username"], let bio = data["bio"]  else {
            return
        }
        registerViewModel.onRegisterTapped(email: email, password: password, confirmpassword: confirmpassword, username: username, bio: bio, profileImg: profileImg, isImageUpload: isImageUpload) {[weak self] user, success, error in
            if success ?? true, let user = user {
                let vc = HomeVC.create(user: user)
                self?.navigationController?.pushViewController(vc, animated: true)
                self?.dismiss(animated: true, completion: nil)
            } else {
                Utility.alert(message: error ?? "")
            }
        }
    }
    
    func chooseImageTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension RegisterVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formData.allFields.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileImageCell.self), for: indexPath) as! ProfileImageCell
            cell.parentVC = self
            cell.prepareToFillData(formData, indexPath: indexPath)
            return cell
        }else if formData.allFields.count > indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InputCell.self), for: indexPath) as! InputCell
            cell.parentVC = self
            cell.prepareToFillData(formData, indexPath: indexPath)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoginButtonCell.self), for: indexPath) as! LoginButtonCell
            cell.parentVC = self
            cell.btnLogin.isHidden = true
            cell.stkViewOr.isHidden = true
            return cell
        }
    }
}

extension RegisterVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // Set the selected image to the ImageView
            isImageUpload = true
            var profileImageIndex: Int?
            for (index, field) in formData.allFields.enumerated() {
                if field.keyName == "profileImage" {
                    profileImageIndex = index
                }
            }
            if let index = profileImageIndex {
                formData.allFields[index].pickedImg = selectedImage
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            }
            profileImg = selectedImage
            
            // Dismiss the image picker controller
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
