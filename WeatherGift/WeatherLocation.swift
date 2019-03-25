//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by BC Swift Student Loan 1 on 3/19/19.
//  Copyright © 2019 Richard Li. All rights reserved.
//

import Foundation
import Alamofire
    class WeatherLocation{
        var name = ""
        var coordinates = ""
        
        func getWeather() {
            let weatherURL = urlBase + urlAPIKey + coordinates
            print(weatherURL)
            Alamofire.request(weatherURL).responseJSON { response in
                print(response)
            }
        }
}
