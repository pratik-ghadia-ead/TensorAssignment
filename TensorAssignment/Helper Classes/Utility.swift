//
//  Utility.swift
//  TensorAssignment
//
//  Created by EAD on 09/10/23.
//

import UIKit

class Utility {
    class func milisecondTOTime(milisecond:Int)->String {
        let sunriseDate = Date(timeIntervalSince1970: Double(milisecond))
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        let formattedTime = formatter.string(from: sunriseDate)
        return  formattedTime
        
    }
    class func alert(message: String, title: String? = "") {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            alert.show()
        }
    }
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    class func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }
    
    class func isValidConfirmPassword(_ password: String, _ confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
    
}
private var kAlertControllerWindow = "kAlertControllerWindow"
extension UIAlertController {
    
    var alertWindow: UIWindow? {
        get {
            return objc_getAssociatedObject(self, &kAlertControllerWindow) as? UIWindow
        }
        set {
            objc_setAssociatedObject(self, &kAlertControllerWindow, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func show() {
        show(animated: true)
    }
    
    func show(animated: Bool) {
        alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow?.rootViewController = UIViewController()
        alertWindow?.windowLevel = UIWindow.Level.alert + 1
        alertWindow?.makeKeyAndVisible()
        alertWindow?.rootViewController?.present(self, animated: animated, completion: nil)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        alertWindow?.isHidden = true
        alertWindow = nil
    }
}
