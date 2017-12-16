//
//  TestViewController.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/15.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import UIKit
import CoreLocation

class TestViewController: UIViewController {
    
    var Location: String?
    var Category: String?
    
    var lat: Double?
    var longt: Double?
    
    let geoCoder = CLGeocoder()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let mapController = childViewControllers.first as? Test1ViewController else {
            fatalError("Check storyboard for missing LocationTableViewController")
        }
        
        geoCoder.geocodeAddressString(Location!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            
            self.lat = location.coordinate.latitude
            self.longt = location.coordinate.longitude
            
            mapController.lat = self.lat!
            mapController.longt = self.longt!
            mapController.Category = self.Category!
            
            mapController.updataMap()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
