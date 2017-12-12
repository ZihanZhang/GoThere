//
//  ViewController.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/10.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {
    @IBOutlet weak var Location: UITextField!
    @IBOutlet weak var Submit: UIButton!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var placesClient: GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()

        
        placesClient = GMSPlacesClient.shared()
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
//            self.nameLabel.text = "No current place"
//            self.addressLabel.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
//                    self.nameLabel.text = place.name
                    self.Location.text = place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n")
                    print(place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n"))
                }
            }
        })
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapFrame = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: UIScreen.main.bounds.size
        )
//        let mapFrame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
        mapView.isMyLocationEnabled = true
//        view = mapView
        
        
        
        self.view.addSubview(mapView)
        self.view.bringSubview(toFront: Location)
        self.view.bringSubview(toFront: Submit)
        self.view.bringSubview(toFront: toolBar)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func Comfirm(_ sender: UIButton) {
        let location = Location.text
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

