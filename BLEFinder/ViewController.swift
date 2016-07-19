//
//  ViewController.swift
//  BLEFinder
//
//  Created by Carlos Morell Roldan on 14/7/16.
//  Copyright © 2016 h1apps. All rights reserved.
//

import UIKit




class ViewController: UIViewController {

    @IBOutlet weak var AdvertiseButton: UIButton!

    
    @IBOutlet weak var SearchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton(AdvertiseButton);
        setupButton(SearchButton);
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupButton(button: UIButton) {
       button.layer.cornerRadius = 10
    }

}

