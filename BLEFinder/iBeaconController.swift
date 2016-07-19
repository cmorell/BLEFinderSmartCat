//
//  iBeaconController.swift
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


class iBeaconController: UIViewController,CBPeripheralManagerDelegate {
   
    
    
    var localBeacon: CLBeaconRegion!
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocalBeacon();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func initLocalBeacon() {
        if self.localBeacon != nil {
            stopLocalBeacon()
        }
        
        let localBeaconUUID = "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5"
        let localBeaconMajor: CLBeaconMajorValue = 123
        let localBeaconMinor: CLBeaconMinorValue = 456
        
        let uuid = NSUUID(UUIDString: localBeaconUUID)!
        self.localBeacon = CLBeaconRegion(proximityUUID: uuid, major: localBeaconMajor, minor: localBeaconMinor, identifier: "WhereIsMyCar")
        
        self.beaconPeripheralData = localBeacon.peripheralDataWithMeasuredPower(nil)
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        self.peripheralManager.state;
    }
    
    func stopLocalBeacon() {
        peripheralManager.stopAdvertising()
        peripheralManager = nil
        beaconPeripheralData = nil
        localBeacon = nil
    }
    
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        if peripheral.state == .PoweredOn {
            peripheralManager.startAdvertising(beaconPeripheralData as! [String: AnyObject]!)
        } else if peripheral.state == .PoweredOff {
            peripheralManager.stopAdvertising()
        }
    }
    
    
}

