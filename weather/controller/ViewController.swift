//
//  ViewController.swift
//  weather
//
//  Created by Mdit on 02/08/19.
//  Copyright © 2019 Mdit. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController ,CLLocationManagerDelegate , Citychng{
    
    let wethr_url = "http://api.openweathermap.org/data/2.5/weather"
    let app_id = "e72ca729af228beabd5d20e3b7749713"
    
    @IBOutlet weak var viewimg: UIImageView!
    @IBOutlet weak var lbltmp: UILabel!
    @IBOutlet weak var lblpro: UILabel!
    
   
    let weatherdata = WeatherData()
    let locationmngr = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationmngr.delegate = self
        locationmngr.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationmngr.requestWhenInUseAuthorization()
        locationmngr.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func citysnd(city: String) {
        
     lblpro.text = "\(city)"
        let params : [String:String] = ["q":city , "appid":app_id]
        
        getWeatherData(url: wethr_url, parameters: params)
        
    }
    //MARK : - networking
    /***********************/
    func getWeatherData(url:String,parameters : [String:String]){
        Alamofire.request(url,method:.get,parameters:parameters).responseJSON
            { response in
                if response.result.isSuccess{
                print("success !got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                    self.updateWeatherData(json:weatherJSON)
                
                }
                else{
                 print("error\(response.result.value!)")
                    self.lblpro.text = "connection issue"
                }
                
        }
    }
    
    // MARK: - UI update
    /***********************************/
    
    func updateWeatherData(json:JSON) {
        if let temResult = json["main"]["temp"].double{
            weatherdata.temparature = Int(temResult - 273.15)
           //temparature = Int(tempResult - 273.15)
            weatherdata.city = json["name"].stringValue
            weatherdata.condition = json["weather"][0]["id"].intValue
            weatherdata.weatherIconName = weatherdata.updateWeatherIcon(condition:weatherdata.condition)
                updateWithWeatherData()
        }else{
            lblpro.text = "weather unavailable"
        }
    }
    
    func updateWithWeatherData() {
        lblpro.text = weatherdata.city
        lbltmp.text = "\(weatherdata.temparature)°C"
        viewimg.image = UIImage(named: weatherdata.weatherIconName)
    }
    
    
    //MARK: - loca
    /******************************/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
          locationmngr.stopUpdatingLocation()
         locationmngr.delegate = nil
            
            print("longitude = \(location.coordinate.longitude),latitude = \(location.coordinate.latitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params : [String:String] = ["lat":latitude,"lon":longitude,"appid":app_id]
            
            getWeatherData(url: wethr_url, parameters: params)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        lblpro.text = "location unavailable"
    
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nxtpg(_ sender: UIButton) {
        performSegue(withIdentifier: "nxt", sender: .none)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nxt" {
            let newObj  = segue.destination as! newViewController
            newObj.delegate = self
        }
    }
}

