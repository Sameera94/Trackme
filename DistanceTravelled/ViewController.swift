//
//  ViewController.swift
//  DistanceTravelled
//
//  Created by lsd on 4/18/17.
//  Copyright © 2017 Leonardo Savio Dabus. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,  CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var straightLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var startDate: Date!
    var traveledDistance: Double = 0
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    
    @IBAction func onClickStart(_ sender: Any) {
        self.traveledDistance = 0
        self.updateDistance(distance: 0.0)
        self.resetView()
        self.startDate = Date()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.distanceFilter = 10
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
    
    @IBAction func onClickStop(_ sender: Any) {
        self.locationManager.stopUpdatingLocation()
        
        FirebaseHandler.addTrip(username: self.username, distance: distanceLabel.text ?? "", amount: straightLabel.text ?? "")
    }
    
    func updateDistance(distance: Double) {
        let distanceInKm = Double(round(100*distance/1000.0)/100)
        updatePrice(distance: distanceInKm)
        distanceLabel.text = "\(distanceInKm) Km"
    }
    
    func updatePrice(distance: Double) {
        straightLabel.text = "Rs. \(String(format: "%.2f", distance * 50.0))"
    }
    
    func resetView() {
        distanceLabel.text = "0.00 Km"
        straightLabel.text = "Rs. 0.00"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if startDate == nil {
            startDate = Date()
        } else {
            straightLabel.text = "Elapsed Time: \(String(format: "%.0fs", Date().timeIntervalSince(startDate)))"
        }
        
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            traveledDistance += lastLocation.distance(from: location)
            self.updateDistance(distance: traveledDistance)
            print("Straight Distance:", startLocation.distance(from: locations.last!))
        }
        
        lastLocation = locations.last
    }
    
    func updateUI() {
        self.startButton.layer.cornerRadius = 10.0
        self.stopButton.layer.cornerRadius = 10.0
        
        self.distanceLabel.clipsToBounds = true
        self.distanceLabel.layer.cornerRadius = 5.0
        
        self.straightLabel.clipsToBounds = true
        self.straightLabel.layer.cornerRadius = 5.0
    }
}
