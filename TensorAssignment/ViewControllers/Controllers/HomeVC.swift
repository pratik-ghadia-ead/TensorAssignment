//
//  HomeVC.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import Foundation
import SDWebImage
import SVProgressHUD
import FirebaseAuth

class HomeVC: UIViewController {
    
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblWeatherLike: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblSunriseTime: UILabel!
    @IBOutlet weak var lblSunsetTime: UILabel!
    
    var user: UserModel?
    let werbservice = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgViewProfile.layer.cornerRadius = imgViewProfile.frame.size.width/2
        imgViewProfile.layer.masksToBounds = true
        imgViewProfile.layer.borderColor = UIColor.black.cgColor
        imgViewProfile.layer.borderWidth = 1.0
        
        if let user = user {
            imgViewProfile?.sd_setImage(with: URL( string:user.profileUrl), completed: nil)
            lblUsername.text = user.username
            lblBio.text = user.bio
        }else {
            let databaseViewModel = DatabaseViewModel()
            let id = UserDefaults.standard.value(forKey: UserDefaultKeys.userId)
            databaseViewModel.fetchDataFromDatabase(withID: id as! String) { [self] user in
                self.user = user
                self.imgViewProfile?.sd_setImage(with: URL(string:user.profileUrl), completed: nil)
                self.lblUsername.text = user.username
                self.lblBio.text = user.bio
            }
        }
        self.getWeatherData(strCity:"New York")
    }
    
    
    func getWeatherData(strCity:String){
        werbservice.getWeather(for: strCity) { [weak self] result in
            SVProgressHUD.show()
            
            switch result {
                
            case .success(let weatherData):
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    guard let me = self else { return }
                    me.lblCity.text = strCity
                    me.lblDesc.text = weatherData.weather?[0].description
                    if let Temp = weatherData.main?.temp as? Double {
                        let str_temp = "\(Int(Temp))" + "\u{00B0}"
                        me.lblTemperature.text = str_temp
                    }
                    let str_sunrise = Utility.milisecondTOTime(milisecond: (weatherData.sys?.sunrise)!)
                    me.lblSunriseTime.text = str_sunrise
                    
                    let str_sunset = Utility.milisecondTOTime(milisecond: (weatherData.sys?.sunset)!)
                    me.lblSunsetTime.text = str_sunset
                    
                    let windsepeed = "\((weatherData.wind?.speed?.roundDouble() ?? ""))" + "m/s"
                    me.lblWindSpeed.text = windsepeed
                    let humidity = "\(weatherData.main?.humidity?.roundDouble() ?? "")"  + "%"
                    me.lblHumidity.text = humidity
                    let feellikes = "\(weatherData.main?.feels_like?.roundDouble() ?? "")"
                    me.lblWeatherLike.text = "Feel like \(feellikes)"
                }
            case .failure(let error):
                SVProgressHUD.dismiss()
            }
        }
    }
    
    
    class func create(user: UserModel) -> HomeVC {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        viewController.user = user
        return viewController
    }
    
    
    // MARK: - Action method
    @IBAction func btnChangeCityTapped(_ sender: UIButton) {
        let main = UIStoryboard(name: "Main", bundle: Bundle.main)
        let cityListVC = main.instantiateViewController(withIdentifier: "CityListVC") as! CityListVC
        cityListVC.cityListSelectionProtocol = self
        self.navigationController?.pushViewController(cityListVC, animated: true)
    }
    @IBAction func btnLogoutTapped(_ sender: UIButton) {
        do
        {
            try Auth.auth().signOut()
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let LoginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            let navigationController = UINavigationController(rootViewController: LoginVC)
            navigationController.setNavigationBarHidden(true, animated: false)
            
            Constant.appDelegate.window?.rootViewController = navigationController
            Constant.appDelegate.window?.makeKeyAndVisible()
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }

}
//MARK: - Custom Delegate
extension HomeVC : CityListSelectionProtocol {
    func selectedCity(success: Bool, dict: [String : Any]) {
        let strSelectedCity = dict["city"] as! String
        if success{
            self.getWeatherData(strCity:strSelectedCity)
        }
    }
}
