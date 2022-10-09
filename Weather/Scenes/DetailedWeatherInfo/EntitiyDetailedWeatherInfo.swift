//
//  EntitiyDetailedWeatherInfo.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 08/10/22.
//


import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let coord: Coord
    let base: String
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}



// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

