//
//  WeatherModel.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import Foundation

struct Weather : Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?
}
struct Main : Codable {
    let temp : Double?
    let humidity : Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
}

struct WeatherData : Codable {
    let weather : [Weather]?
    let main : Main?
    let wind : Wind?
    let sys : Sys?
    let name : String?
    let visibility : Int?
}

struct Wind : Codable {
    let speed : Double?
    let deg : Int?
}

struct Sys : Codable {
    let type : Int?
    let id : Int?
    let country : String?
    let sunrise : Int?
    let sunset : Int?
}
