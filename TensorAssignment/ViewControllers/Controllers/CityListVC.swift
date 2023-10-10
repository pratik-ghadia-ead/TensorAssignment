//
//  CityListVC.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import UIKit

protocol CityListSelectionProtocol {
    func selectedCity(success:Bool ,dict: [String:Any])
}


class CityListVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var cityListViewModel = CityListViewModel()
    var arrCityList = [CityModel]()
    var cityListSelectionProtocol:CityListSelectionProtocol?
    var intSelectedIndex : Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    func setUpUI(){
        self.cityListViewModel.cityListVC = self
        self.cityListViewModel.getCityList()
    }
    
    // MARK: - Action method

    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDoneTapped(_ sender: UIButton) {
        let objCity = self.arrCityList[intSelectedIndex]
        
        var dictSelecteCity = [String: Any]()
        dictSelecteCity["city"]  = objCity.name
        dictSelecteCity["lat"]   = objCity.lat
        dictSelecteCity["lng"]   = objCity.lon
        
        cityListSelectionProtocol?.selectedCity(success: true, dict: dictSelecteCity)
        self.navigationController?.popViewController(animated: true)

    }
    
}

// MARK: - TableView

extension CityListVC:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as? CityCell
        if cell == nil {
            let arrNib : Array = Bundle.main.loadNibNamed("CityCell",owner: self, options: nil)!
            cell = arrNib[0] as? CityCell
            cell?.selectionStyle = .none
        }
        
        cell?.lblCity.text = self.arrCityList[indexPath.row].name
        cell?.imgSelect.image = nil
        if intSelectedIndex == indexPath.row{
            cell?.imgSelect.image = UIImage(systemName: "dot.circle.fill")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var oldIndexPath = indexPath
        if intSelectedIndex != -1{
             oldIndexPath = IndexPath(row: intSelectedIndex, section: indexPath.section)
        }
        self.intSelectedIndex = indexPath.row
        self.tableView.reloadRows(at: [indexPath], with: .none)
        self.tableView.reloadRows(at: [oldIndexPath], with: .none)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
