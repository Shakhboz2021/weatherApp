//
//  InteracterDetailedWeatherInfo.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 08/10/22.
//

import Foundation
import Alamofire

protocol DetailedWeatherInfoInteractorProtocol {
    var presenter: DetailedWeatherInfoPresenterProtoccol? { get set }
    func weatherForToday(completion: @escaping (_ result: WeatherResponse<Forecast>) -> Void)
}

class DetailedWeatherInfoInteractor: DetailedWeatherInfoInteractorProtocol {
    var params: [String : Any]
    
    init(params: [String : Any]) {
        self.params = params
    }
    
    func weatherForToday(completion: @escaping (WeatherResponse<Forecast>) -> Void) {
        
        let urlForWeatherToday = WeatherAPI.getURL(params: params, forToday: true)
        
        AF.request(urlForWeatherToday)
            .validate()
            .responseDecodable(of: Forecast.self) { data in
                
                if data.error != nil {
                    completion(WeatherResponse.failure(ErrorType.other))
                    return
                }
                
                if let forecast = data.value {
                    completion(WeatherResponse.success(forecast))
                }
            }
    }
    
    var presenter: DetailedWeatherInfoPresenterProtoccol?
    
}
