//
//  Constants.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 06/10/22.
//

import Foundation

struct UDManagerConstants {
    static let languageKey = "LANGUAGE_KEY"
}

struct WeatherAPI {
    static let basicURL = "https://api.openweathermap.org/data/2.5/"
    static let apiKey = "648a3aac37935e5b45e09727df728ac2"
    
    static func getURL(params: [String:Any], forToday: Bool = false) -> String {
        var url = basicURL + "forecast/daily?units=metric&"
        if forToday {
            url = basicURL + "weather?units=metric&"

        }
        
        for param in params {
            url += "\(param.key)=\(param.value)&"
        }
        
        url += "APPID=\(apiKey)"
        
        return url
        
    }
    
}

