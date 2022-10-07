//
//  Response.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 06/10/22.
//

import Foundation

public typealias APIData = (Codable & Error)

enum ErrorType: Error {
    case noInternet
    case other
}

enum WeatherResponse<Value> {
    case success(Value)
    case failure(ErrorType)
}
