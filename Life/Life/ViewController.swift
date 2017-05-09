//
//  ViewController.swift
//  Life
//
//  Created by Tyler Wilson on 4/11/17.
//  Copyright © 2017 Tyler Wilson. All rights reserved.
//

import UIKit
import CoreData

//TUTORIAL WITH PERMISSIONS 
//CORRECT TEMP, DATE, DAY
//DATABASE TO CALL WEATHER ONCE PER 3 HOURS, DATE AND DAY ONCE PER DAY
//EDIT EVENTS WHEN TAP ON CELL
//ADD EVENTS

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
        
    @IBOutlet weak var eventTableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var sportsTable: UITableView!
    
    
    var weatherData = WeatherMap()
    var dateAndTime = DateAndTime()
    var calendar = CalendarEvents()
    var sportsNews = SportsNews()

    var displayWeather = [String:Array<Any>](){
        didSet{
            weatherCollectionView.delegate = self
            weatherCollectionView.dataSource = self
            DispatchQueue.main.async(){
                self.weatherCollectionView.reloadData()
            }
        }
    }
    
    var displayEvents = [String: Array<String>](){
        didSet{
            eventTableView.delegate = self
            eventTableView.dataSource = self
            DispatchQueue.main.async(){
                self.eventTableView.reloadData()
            }
        }
    }
    
    var sportsHeadLines = [String](){
        didSet{
            sportsTable.delegate = self
            sportsTable.dataSource = self
            DispatchQueue.main.async(){
                self.sportsTable.reloadData()
            }
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherData.delegate = self
        calendar.delegate = self
        
        sportsNews.setUpParser()
        calendar.getEvents()
        weatherData.parseWeather()
        
        sportsNews.delegate = self
        
        dateLabel.text = dateAndTime.getDate()
        dayLabel.text = dateAndTime.getDay()
        
    }
    
    
    
    
    // MARK: - COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        cell.cellLabel.text = displayWeather["time"]?[indexPath.item] as? String
        cell.hourTemp.text = displayWeather["temp"]?[indexPath.item] as? String
        cell.iconImageView.image = displayWeather["icon"]?[indexPath.item] as? UIImage
        return cell
    }
    
    // MARK: - TABLE VIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return displayEvents.count - 1
    }
    
    //REPEATED CODE
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = eventTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.font = UIFont(name: "Kohinoor Bangla", size: 20)
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
            cell.textLabel?.text = displayEvents["title"]?[indexPath.item]
            cell.detailTextLabel?.text = "Ending on: " + (displayEvents["endTime"]?[indexPath.item])!
            return cell
    }
    
    
    
}

extension ViewController: WeatherMapDelegate, CalendarEventsDelegate, SportsNewsDelegate{
    func didGetWeather(data: [String:Array<Any>]) {
        displayWeather = data
    }
    
    func receivedEvents(events: [String: Array<String>]) {
        displayEvents = events
    }
    
    func getSportsNews(data: [String]) {
        sportsHeadLines = data
    }

}
