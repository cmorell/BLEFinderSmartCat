//
//  LocationManagerController.swift
//  BLEFinder
//
//  Created by Carlos Morell Roldan on 14/7/16.
//  Copyright © 2016 h1apps. All rights reserved.
//

//
//  ViewController.swift
//  BLEFinder
//
//  Created by Carlos Morell Roldan on 14/7/16.
//  Copyright © 2016 h1apps. All rights reserved.
//

import UIKit


import CoreBluetooth
import CoreLocation


class LocationManagerController: UIViewController,CLLocationManagerDelegate {
   
    @IBOutlet weak var whereIsLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    var locationManager: CLLocationManager!
    
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intAsADetecterBeacon()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func intAsADetecterBeacon(){
        locationManager = CLLocationManager()
         locationManager.delegate = self
         locationManager.requestAlwaysAuthorization()
        
        
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .NotDetermined:
            manager.requestWhenInUseAuthorization()
            
            break
        case .AuthorizedWhenInUse:
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
            
            break
        case .AuthorizedAlways:
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
            break
        case .Restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .Denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            let beacon = beacons[0]
            rssiLabel.text = String(beacon.rssi)
            updateDistance(beacon.proximity)
        } else {
            updateDistance(.Unknown)
        }
    }
    
    func updateDistance(distance: CLProximity) {
        UIView.animateWithDuration(0.8) {
            switch distance {
            case .Unknown:
                self.view.backgroundColor = UIColor.grayColor()
                self.whereIsLabel.text = "Unknown"
            case .Far:
                self.view.backgroundColor = UIColor.redColor()
                self.whereIsLabel.text = "Far"
            case .Near:
                self.view.backgroundColor = UIColor.orangeColor()
                 self.whereIsLabel.text = "Near"
            case .Immediate:
                self.view.backgroundColor = UIColor.greenColor()
                 self.whereIsLabel.text = "Immediate"
            }
        }
    }
    
    
    func startScanning() {
        let uuid = NSUUID(UUIDString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 123, minor: 456, identifier: "WhereIsMyCar")
        
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    
    
    
    
}


