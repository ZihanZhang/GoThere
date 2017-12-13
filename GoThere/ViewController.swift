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
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var Location: UITextField!
    @IBOutlet weak var Submit: UIButton!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var Explore: UIButton!
    var mapView:GMSMapView?
    
    var placesClient: GMSPlacesClient!
    let geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        Explore.isHidden = true
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
                    self.Location.text = place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n")
                    let lat = place.coordinate.latitude
                    let lon = place.coordinate.longitude
                    let address = place.name
////                    self.nameLabel.text = place.name
                    
                    let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 6.0)
                    let mapFrame = CGRect(
                        origin: CGPoint(x: 0, y: 0),
                        size: UIScreen.main.bounds.size
                    )
                    //        let mapFrame = CGRect(x: 0, y: 0, width: 200, height: 200)
                    self.mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
                    self.mapView?.isMyLocationEnabled = true
                    //        view = mapView
                    
                    
                    
                    self.view.addSubview(self.mapView!)
                    self.view.bringSubview(toFront: self.Location)
                    self.view.bringSubview(toFront: self.Submit)
                    self.view.bringSubview(toFront: self.toolBar)
                    
                    // Creates a marker in the center of the map.
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    marker.title = address
                    marker.snippet = address
                    marker.map = self.mapView

                }
            }
            
        })
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func Comfirm(_ sender: UIButton) {
        let address = Location.text
        
        geoCoder.geocodeAddressString(address!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            
            let lat = location.coordinate.latitude
            let longt = location.coordinate.longitude
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: longt, zoom: 6.0)
            let mapFrame = CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: UIScreen.main.bounds.size
            )
            self.mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
            self.mapView?.isMyLocationEnabled = true
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: longt)
            marker.title = address
            marker.snippet = address
            marker.map = self.mapView
            
//            print("lat" , lat , "lon" , longt)
            
            self.view.subviews[0].removeFromSuperview() // this gets things done

            self.view.addSubview(self.mapView!)
//            self.view.bringSubview(toFront: self.Location)
//            self.view.bringSubview(toFront: self.Submit)
            self.view.bringSubview(toFront: self.toolBar)
            self.Explore.isHidden = false
            self.view.addSubview(self.Explore)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

