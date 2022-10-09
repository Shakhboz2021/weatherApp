//
//  ViewDetailedWeatherInfo.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 08/10/22.
//

import UIKit
import SnapKit

protocol DetailedWeatherInfoViewProtoccol {
    var presenter: DetailedWeatherInfoPresenterProtoccol? { get set }
    func update(with weatherData: Forecast)
}

class DetailedWeatherInfoView: UIViewController, DetailedWeatherInfoViewProtoccol {
    var presenter: DetailedWeatherInfoPresenterProtoccol?
    var weatherData: Forecast?
    
    //Outlets
    lazy var parentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var lblCityName: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()
    
    lazy var lblCountryCode: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        return lbl
    }()
    
    lazy var lblSunrise: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()
    lazy var lblSunset: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()
    
    lazy var btn: UIButton = {
        
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .lightGray
        btn.setTitle("get_weekly_weather_info".localized(), for: .normal)
        btn.addTarget(self, action: #selector(getWeeklyWeather), for: .touchUpInside)
        return btn
        
    }()
    
    override func loadView() {
        super.loadView()
        setInitialView()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "weather".localized()
    }
    
    @objc func getWeeklyWeather() {
        presenter?.getWeeklyWeather(cityName: weatherData?.name ?? "")
    }
    
    func update(with weatherData: Forecast) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        
        DispatchQueue.main.async {
            self.weatherData = weatherData
            
            self.lblCityName.text = "city".localized() + weatherData.name
            self.lblCountryCode.text = "country".localized() + weatherData.sys.country
            self.lblSunset.text = "sunset".localized() + formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weatherData.sys.sunset)))
            self.lblSunrise.text = "sunrise".localized() + formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weatherData.sys.sunrise)))
        }
    }
}


extension DetailedWeatherInfoView {
    
    func setInitialView() {
        view.addSubview(parentView)
        parentView.addSubview(lblCityName)
        parentView.addSubview(lblCountryCode)
        parentView.addSubview(lblSunrise)
        parentView.addSubview(lblSunset)
        parentView.addSubview(btn)
    }
    
    func setConstraints() {
        
        parentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        lblCityName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        lblCountryCode.snp.makeConstraints { make in
            make.top.equalTo(lblCityName.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        lblSunset.snp.makeConstraints { make in
            make.top.equalTo(lblCountryCode.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        lblSunrise.snp.makeConstraints { make in
            make.top.equalTo(lblSunset.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        btn.snp.makeConstraints { make in
            make.top.equalTo(lblSunrise.snp.bottom).offset(8)
            make.height.equalTo(44)
            make.right.equalToSuperview().inset(16)
            make.left.equalToSuperview().offset(16)
        }
    }
}
