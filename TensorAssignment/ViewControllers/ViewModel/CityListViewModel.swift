//
//  CityListViewModel.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import Foundation

class CityListViewModel{
    
    var cityListVC : CityListVC?
    
    func getCityList(){
        
        if let fileURL = Bundle.main.url(forResource: "USCityList", withExtension: "json") {
            do {
                
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let cityList = try decoder.decode([CityModel].self, from: data)
                for cityList in cityList {
                    self.cityListVC?.arrCityList.append(cityList)
                }
                cityListVC?.tableView.reloadData()
                
            } catch {
                print("Error reading JSON file: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
    }
}

