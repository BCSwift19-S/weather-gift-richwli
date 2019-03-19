//
//  DetailVC.swift
//  WeatherGift
//
//  Created by BC Swift Student Loan 1 on 3/8/19.
//  Copyright © 2019 Richard Li. All rights reserved.
//

import UIKit
import CoreLocation

class DetailVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    var currentPage = 0
    var locationsArray = [WeatherLocation]()
    var locationManger: CLLocationManager!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationLabel.text = locationsArray[currentPage].name
        dateLabel.text = locationsArray[currentPage].coordinates
    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if currentPage == 0{
            getLocation()
        }
    }
}

extension DetailVC: CLLocationManagerDelegate {
    func getLocation(){
        locationManger = CLLocationManager()
        locationManger.delegate = self
        let status = CLLocationManager.authorizationStatus()
        handleLocationAuthorizationStatus(status: status)
    }
    
    func  handleLocationAuthorizationStatus(status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        
        case .authorizedAlways, .authorizedWhenInUse:
            locationManger.requestLocation()
            
        case .denied:
            print("I am sorry. I cannot show location as user has denied location request.")
            
        case .restricted:
            print("Access denied. Likely parental controls are restricting location services within this app.")
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        let currentLatitude = currentLocation.coordinate.latitude
        let currentLongitude = currentLocation.coordinate.longitude
        let currentCoordinates = "\(currentLatitude)\(currentLongitude)"
        print(currentCoordinates)
        dateLabel.text = currentCoordinates
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Failed to get user location.")
    }
}
