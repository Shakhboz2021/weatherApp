//
//  PresentorDailyWeatherList.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 07/10/22.
//

import Foundation

// Object
// Protocol
// ref to interactor, router, view

protocol DailyWeatherListPresenterProtocol: AnyObject {
    var router: DailyWeatherListRouterProtocol? { get set }
    var interactor: DailyWeatherListInteractorProtocol? { get set }
    var view: DailyWeatherListViewProtocol? { get set }
}

class DailyWeatherListPresenter: DailyWeatherListPresenterProtocol {
    
    var router: DailyWeatherListRouterProtocol?
    
    var interactor: DailyWeatherListInteractorProtocol? {
        didSet {
            interactor?.getWeatherData(completion: { result in
                switch result {
                case .success(let weather):
                    print(weather.list, weather.list.count)
                    self.view?.update(with: weather)
                case .failure(let errorType):
                    print(errorType)
                }
            })
        }
    }
    
    var view: DailyWeatherListViewProtocol?
    
}

