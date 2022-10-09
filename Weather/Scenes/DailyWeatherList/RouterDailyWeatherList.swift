//
//  DailyWeatherListEntity.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 07/10/22.
//
import UIKit

//Object
//Entry point

typealias EntryPoint = DailyWeatherListViewProtocol & UIViewController

protocol DailyWeatherListRouterProtocol: AnyObject {
    var entry: EntryPoint? { get }
    static func presentWeatherList() -> DailyWeatherListRouterProtocol
}

class DailyWeatherListRouter: DailyWeatherListRouterProtocol {
    var entry: EntryPoint?
        
    static func presentWeatherList() -> DailyWeatherListRouterProtocol {
        let router = DailyWeatherListRouter()
        
        //Assign VIP
        var view: DailyWeatherListViewProtocol = DailyWeatherListView()
        let presenter: DailyWeatherListPresenterProtocol = DailyWeatherListPresenter()
        var interactor: DailyWeatherListInteractorProtocol = DailyWeatherListInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor as! DailyWeatherListInteractor
        presenter.view = view
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
