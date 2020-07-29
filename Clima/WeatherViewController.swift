//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
class WeatherViewController: UIViewController , CLLocationManagerDelegate , ChangeCityDelegate{
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    
    
    //instance variables
    let locationManager = CLLocationManager()
    var weatherDataModel = WeatherDataModel()
    
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Set up the location manager.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // locationManager.delegate = nil
    }
    
    
    
    //MARK: - Networking
    
    
    //Write the getWeatherData method here:
    
    func getWeatherData (url : String , params : [String:String])
    {
        Alamofire.request(url , method : .get , parameters : params ).responseJSON
            {
                response in
                if response.result.isSuccess              {
                    print("You Got the weather Success")
                    let weatherJSON : JSON = JSON(response.result.value!)
                    self.updateWeatherData(json: weatherJSON)
                    print(weatherJSON)
                }
                else
                {
                    print("error: \(response.result.error!)")
                    self.cityLabel.text = "Internet Connection Failed!"
                }
                
        }
    }
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //updateWeatherData method:
    func updateWeatherData(json : JSON)
    {
        if let tembreture = json["main"]["temp"].double
        {
            weatherDataModel.tempreture = Int(tembreture - 273.15)// convert the unit
            weatherDataModel.city = json["name"].stringValue
//            weatherDataModel.condition = json["condition"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherData()
        }
        else
        {
            cityLabel.text = "Connection probelm"
        }
        
    }
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    func updateUIWithWeatherData()
    {
        temperatureLabel.text = String(weatherDataModel.tempreture)
        cityLabel.text = weatherDataModel.city
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location  = locations[locations.count - 1]
        if location.horizontalAccuracy > 0
        {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            print("latitude \(location.coordinate.latitude), langitude = \(location.coordinate.longitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params : [String : String]  = ["lat" : latitude , "long" : longitude , "APPID" : APP_ID]
            getWeatherData(url: WEATHER_URL, params: params)
        }
    }
    
    //Write the didFailWithError method here:
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "location unavaliable"
    }
    
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName (city : String){
        let params : [String : String] = ["q" : city , "appid" : APP_ID ]
        getWeatherData(url: WEATHER_URL, params: params)
    }
    
    
    //Write the PrepareForSegue Method here
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"
        {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    
    
    
}
