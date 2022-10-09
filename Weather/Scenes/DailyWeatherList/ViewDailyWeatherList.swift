//
//  DailyWeatherListRouter.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 07/10/22.
//

import UIKit
import SnapKit

// ViewController
// Protocol
// ref to presenter

protocol DailyWeatherListViewProtocol {
    var presenter: DailyWeatherListPresenterProtocol? { get set }
    
    func update(with dailyWeather: WeatherModel)
}

class DailyWeatherListView: UIViewController, DailyWeatherListViewProtocol {
    
    var weatherData: WeatherModel?
    var presenter: DailyWeatherListPresenterProtocol?
    
    lazy var tableView: UITableView = {
        
        let tv =  UITableView()
        tv.register(WweatherCell.self, forCellReuseIdentifier: WweatherCell.identifier)
        tv.rowHeight = 60
        tv.isHidden = true
        
        return tv
        
    }()
    
    override func loadView() {
        super.loadView()
        setInitialView()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = weatherData?.city.name
    }
    
    func setInitialView() {
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
    }
    
    func update(with dailyWeather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherData = dailyWeather
            self.title = dailyWeather.city.name
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
}

extension DailyWeatherListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let data = weatherData else { return UITableViewCell() }
        let forecast = data.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WweatherCell.identifier, for: indexPath) as! WweatherCell
        
        cell.setContent(info: forecast)
        
        return cell
    }
}

extension DailyWeatherListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
