//
//  LoginVC.swift
//  TensorAssignment
//
//  Created by EAD on 09/10/23.
//

import UIKit

public class LoginVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var formData: UserDataSpecifier = UserDataSpecifier(.login)
    private let loginViewModel = LoginViewModel()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "InputCell", bundle: nil), forCellReuseIdentifier: "InputCell")
        self.tableView.register(UINib(nibName: "LoginButtonCell", bundle: nil), forCellReuseIdentifier: "LoginButtonCell")
        self.tableView.reloadData()
    }
}

// MARK: Cell handler
extension LoginVC {
    func loginTapped() {
        let data = formData.paramDictionaty()
        guard let email = data["email"], let password = data["password"] else {
            return
        }
        loginViewModel.onLoginTapped(email: email, password: password) { [weak self] user, success, error in
            if success ?? true, let user = user {
              
                let vc = HomeVC.create(user: user)
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                Utility.alert(message: error ?? "")
            }
        }
    }
    
    func registerTapped() {
        let vc = RegisterVC.create()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formData.allFields.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if formData.allFields.count > indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InputCell.self), for: indexPath) as! InputCell
            cell.parentVC = self
            cell.prepareToFillData(formData, indexPath: indexPath)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoginButtonCell.self), for: indexPath) as! LoginButtonCell
            cell.parentVC = self
            return cell
        }
    }
}
