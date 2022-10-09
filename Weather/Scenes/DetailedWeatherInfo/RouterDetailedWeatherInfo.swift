//
//  RouterDetailedWeatherInfo.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 08/10/22.
//

import UIKit

//Object
//Entry point

typealias DetailedInfoViewType = DetailedWeatherInfoViewProtoccol & UIViewController

protocol DetailedWeatherInfoRouterProtocol {
    var entryPoint: DetailedInfoViewType? { get }
    static func getWeatherDetails(with coord: Coord) -> DetailedWeatherInfoRouterProtocol
    func goToWeeklyWeather(cityName: String)
}

class DetailedWeatherInfoRouter: DetailedWeatherInfoRouterProtocol {
    func goToWeeklyWeather(cityName: String) {
        let weatherRouter = DailyWeatherListRouter.presentWeatherList()
        guard let vc = weatherRouter.entry else { return }
        entryPoint?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    var entryPoint: DetailedInfoViewType?
    
    static func getWeatherDetails(with coord: Coord) -> DetailedWeatherInfoRouterProtocol {
        
        let router = DetailedWeatherInfoRouter()

        let params: [String:Any] = [
            "lang": UDManager.shared.currentLanguageKey,
            "lon": coord.lon,
            "lat": coord.lat
        ]
        
        // Assign VIP
        var view: DetailedWeatherInfoViewProtoccol = DetailedWeatherInfoView()
        var presenter: DetailedWeatherInfoPresenterProtoccol = DetailedWeatherInfoPresenter()
        var interactor: DetailedWeatherInfoInteractorProtocol = DetailedWeatherInfoInteractor(params: params)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.entryPoint = view as? DetailedInfoViewType
        
        return router
        
    }
    
    
}
