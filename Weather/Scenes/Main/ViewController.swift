//
//  ViewController.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 05/10/22.
//

import MapKit
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var getWeatherButton: UIButton!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeatherButton.layer.cornerRadius = 12
        getWeatherButton.setTitle("get_weather_info".localized(), for: .normal)
        let languageBtn = UIBarButtonItem(image: UIImage(named: "language"), style: .plain, target: self, action:#selector(chooseLanguage))
        navigationItem.rightBarButtonItem = languageBtn
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    @IBAction func weatherButtonPressed(_ sender: Any) {
        
        let coord = Coord(lon: mapView.region.center.longitude, lat: mapView.region.center.latitude)
        
        let weatherRouter = DetailedWeatherInfoRouter.getWeatherDetails(with: coord)
        guard let vc = weatherRouter.entryPoint else { return }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func chooseLanguage() {
        let ac = UIAlertController(title: "choose_languge".localized(), message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "English", style: .default, handler: changeLanguage))
        ac.addAction(UIAlertAction(title: "Русский", style: .default, handler: changeLanguage))
        ac.addAction(UIAlertAction(title: "O'zbekcha", style: .default, handler: changeLanguage))
        ac.addAction(UIAlertAction(title: "choose".localized(), style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func changeLanguage(action: UIAlertAction) {
        if action.title == "English" {
            Bundle.setAppLanguage(lan: "en")
        } else if action.title == "Русский" {
            Bundle.setAppLanguage(lan: "ru")
        } else if action.title == "O'zbekcha" {
            Bundle.setAppLanguage(lan: "uz")
        }
        getWeatherButton.setTitle("get_weather_info".localized(), for: .normal)
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        manager.stopUpdatingLocation()
        render(location)
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let currentRegion = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(currentRegion, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        
    }
    
}
