//
//  ViewController.swift
//  Clima
//
//  Created by Hamed Tara on 2023-12-30.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextFiled: UITextField!
    
    var weathermanager = weatherManager();
    
    let locationManager = CLLocationManager();

    @IBAction func locationButton(_ sender: UIButton) {
        
        locationManager.requestLocation();
    }
    
    
    
    
}






//MARK: - UITextFiledDelegate



extension WeatherViewController : UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextFiled.endEditing(true);
      //  print(searchTextFiled.text!);
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // Asking from the user to confirom that we are using the GPS
        
        locationManager.requestWhenInUseAuthorization();
        
        // This requst is not a live tracking reuest .
        
        
        locationManager.delegate = self;
        
        locationManager.requestLocation();

        
        searchTextFiled.delegate = self;
        
        weathermanager.delegate = self;
        
        
        
      //  locationManager.delegate = self;
        
        // Do any additional setup after loading the view.
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      //  print(searchTextFiled.text!)
        searchTextFiled.endEditing(true);
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.placeholder != ""){
            return true ;
        }else {
            textField.placeholder = "You Forgot To Type ";
            return false   ;
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextFiled.text {
            weathermanager.fetchWeather(cityName: city)
            
        }
        
        searchTextFiled.text = "";
    }
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{

    func didUpdateWeather(_ weatherManager :weatherManager,  weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString;
            self.conditionImageView.image = UIImage(systemName: weather.conditionName);
            self.cityLabel.text = weather.cityName;
        }
            }
        func didFailedWithError(error: Error){
        print(error);
    }
    
}


//MARK: - CLLocationManagerDeligate


extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Implementation
        //print("Updated locations test hfiehihei: \(locations)")
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation();
            let lat = location.coordinate.latitude;
            let lon = location.coordinate.longitude;
            weathermanager.fetchWeather(latitude:lat,longitude:lon);
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle error
        print(error)
    }
}
