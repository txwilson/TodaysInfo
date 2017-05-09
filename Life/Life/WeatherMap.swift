//
//  Parser.swift
//  Life
//
//  Created by Tyler Wilson on 4/11/17.
//  Copyright © 2017 Tyler Wilson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol WeatherMapDelegate: class {
    func didGetWeather(data: [String: Array<Any>])
}

class WeatherMap {
    
    weak var delegate:WeatherMapDelegate?
    
    var dateAndTime = DateAndTime()
    
    let weatherEntity = NSEntityDescription.insertNewObject(forEntityName: "Weather", into: DataBaseController.getContext()) as! Weather
    
    private let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?zip=47304&units=imperial&APPID=b0f05a7900ef6e71123d9a1e79e38ad7")
    
    private var times = ["Now"]
    private var tempArray = [String]()
    private var iconArray = [UIImage]()
    private var stringIconArray = [String]()
    private var weather = [String: Array<Any>]()
    
    
    var count = 0
    
    let weatherIconDictionary = [
        "01d": "sunny.png",
        "02d": "partlyCloudy.png",
        "03d": "cloudy.png",
        "04d": "brokenClouds.png",
        "10d": "rainDay.png",
        "11d": "storm",
        "13d": "snow.png",
        "50d": "mist.png",
        "01n": "clearSky.png",
        "02n": "partlyCloudyNight",
        "03n": "cloudy.png",
        "04n": "brokenClouds.png",
        "10n": "rainDay.png",
        "11n": "storm",
        "13n": "snow.png",
        "50n": "mist.png"
    ]
    
    func addToDataBase(){
        for i in 1...5 {
            weatherEntity.temp = tempArray[i]
            weatherEntity.icon = stringIconArray[i]
            weatherEntity.updatedTime = dateAndTime.getHour()
        }
        
        DataBaseController.saveContext()
    }

    func parseWeather(){
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let weather = json["list"] as? [[String:Any]] {
                    for data in weather {
                        if let weatherDescription = data["weather"] as? [[String:Any]]{
                            for description in weatherDescription {
                                if let weatherIcon = description["icon"] as? String {
                                    self.addWeatherToDictionary(weatherData: weatherIcon, identifier: "icon")
                                }
                            }
                        }
                        
                        if let main = data["main"] as? [String:Any] {
                            if let temp = main["temp"] as? Int {
                                self.addWeatherToDictionary(weatherData: String(temp), identifier: "temp")
                            }
                        }
                    }
                }
            }catch{
                print(error)
            }
        }).resume()
    }
    
    private func addWeatherToDictionary(weatherData: String, identifier: String){
        if count < 10 {
            switch identifier {
            case "temp":
                tempArray.append(weatherData + "℉")
            case "icon":
                stringIconArray.append(weatherData)
                getWeatherIcons(icon: weatherData)
            default:
                return
            }
            count += 1
        }else if count == 10 {
            getTimes()
            weather["temp"] = tempArray
            weather["icon"] = iconArray
            delegate?.didGetWeather(data: weather)
        }
    }
    
    private func getTimes(){
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date) + 3
        for _ in 1...4{
            if hour > 12 && hour < 24{
                times.append(String(hour % 12) + ":00pm")
                hour += 3
            }else {
                times.append(String(hour % 12) + ":00am")
                hour += 3
            }
        }
        weather["time"] = times
    }
    
    private func getWeatherIcons(icon: String){
        let iconImage = UIImage(named: weatherIconDictionary[icon]!)
        iconArray.append(iconImage!)
    }
    
    func shouldUpdateWeather() {
        let fetchRequest:NSFetchRequest<Weather> = Weather.fetchRequest()
        
        do{
            let results = try DataBaseController.getContext().fetch(fetchRequest)
            
            for result in results {
//                print(result.updatedTime)
//                if (dateAndTime.getHour()) - result.updatedTime >= 3{
//                    print("time to update")
//                    parseWeather()
//                }else {
//                    print("dont update")
//                    return
//                }
                
                print(result)
            }
            
            
        }catch{
            print("Error: \(error)")
        }
    }
    
    

}
