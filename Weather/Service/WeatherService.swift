//
//  WeatherService.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 06/10/22.
//

import Foundation
import Alamofire

struct WeatherService {
    
    static let shared = WeatherService()
    
    func fetchWeatherData(url: String, completion: @escaping (_ result: WeatherResponse<WeatherModel>) -> Void) {
        print(url)
        AF.request(url)
            .validate()
            .responseDecodable(of: WeatherModel.self) { data in
                
                if data.error != nil {
                    completion(WeatherResponse.failure(ErrorType.other))
                    return
                }
                
                if let weather = data.value {
                    completion(WeatherResponse.success(weather))
                }
                
            }
    }
    
}
