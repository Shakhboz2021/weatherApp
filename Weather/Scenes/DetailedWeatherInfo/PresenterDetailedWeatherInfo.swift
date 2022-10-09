//
//  PresenterDetailedWeatherInfo.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 08/10/22.
//

import Foundation

protocol DetailedWeatherInfoPresenterProtoccol {
    var router: DetailedWeatherInfoRouterProtocol? { get set }
    var interactor: DetailedWeatherInfoInteractorProtocol? { get set }
    var view: DetailedWeatherInfoViewProtoccol? { get set }
    func getWeeklyWeather(cityName: String)
}

class DetailedWeatherInfoPresenter: DetailedWeatherInfoPresenterProtoccol {
    
    var router: DetailedWeatherInfoRouterProtocol?
    
    var interactor: DetailedWeatherInfoInteractorProtocol? {
        didSet {
            interactor?.weatherForToday(completion: { result in
                switch result {
                case .success(let weather):
                    self.view?.update(with: weather)
                case .failure(let errorType):
                    print(errorType)
                }
            })
        }
    }
    
    var view: DetailedWeatherInfoViewProtoccol?
    
    func getWeeklyWeather(cityName: String) {
        
        router?.goToWeeklyWeather(cityName: cityName)
        
//        let weatherRouter = DailyWeatherListRouter.presentWeatherList()
//        guard let vc = weatherRouter.entry else { return }
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}
