//
//  WeatherService.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import Foundation

class WeatherService {

    func getWeather(for cityname:String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(Constant.weatherBaseURL)?q=\(cityname)&appid=\(Constant.weatherApiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherData.self, from: data)
                    completion(.success(weatherData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
