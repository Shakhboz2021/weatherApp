//
//  InteractorDailyWeatherList.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 07/10/22.
//

import Foundation
import Alamofire
// Object
// protocol
// ref to presenter

protocol DailyWeatherListInteractorProtocol {
    var presenter: DailyWeatherListPresenterProtocol? { get set}
    
    func getWeatherData(completion: @escaping (_ result: WeatherResponse<WeatherModel>) -> Void)
    
}

class DailyWeatherListInteractor: DailyWeatherListInteractorProtocol {
    var presenter: DailyWeatherListPresenterProtocol?
    
    func getWeatherData(completion: @escaping (_ result: WeatherResponse<WeatherModel>) -> Void) {
        
        let params = [
            "q":"Tashkent",
            "lang": UDManager.shared.currentLanguageKey,
            "cnt":16
        ] as [String : Any]
        
        let urlForDailyWeather = WeatherAPI.getURL(params: params)
        
        AF.request(urlForDailyWeather)
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
