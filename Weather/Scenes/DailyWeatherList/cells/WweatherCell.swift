//
//  WweatherCell.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 08/10/22.
//

import UIKit

class WweatherCell: UITableViewCell {

    static let identifier = "WeatherCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var dayLabel: UILabel = {
       
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return lbl
        
    }()
    
    lazy var minMaxTempLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .lightGray
        return lbl
        
    }()
    
    func setContent(info: List) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE (dd MMM)"
        let weekDay = formatter.string(for: Date(timeIntervalSince1970: TimeInterval(info.dt)))
        
        dayLabel.text = weekDay
        minMaxTempLabel.text = "daily_temp".localized() + "(°C): \(lround(info.temp.min))" + " ~ \(lround(info.temp.max))"
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        constructHierarchy()
        activateConstraints()
    }
    
}

extension WweatherCell {
    func constructHierarchy() {
        addSubview(dayLabel)
        addSubview(minMaxTempLabel)
    }
    func activateConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        minMaxTempLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }
}
