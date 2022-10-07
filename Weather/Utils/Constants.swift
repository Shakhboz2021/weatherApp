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
    
    static func getURL(params: [String:Any]) -> String {
        
        var url = "https://api.openweathermap.org/data/2.5/forecast/daily?"
        
        for param in params {
            url += "\(param.key)=\(param.value)&"
        }
        
        url += "APPID=\(apiKey)"
        
        return url
        
    }
    
}

