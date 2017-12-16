//
//  Test1ViewController.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/15.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class Test1ViewController: UIViewController, GMSMapViewDelegate {
    
    var lat: Double = 10
    var longt: Double = 20
    var Category: String?
    
    var mapView: GMSMapView?
    
    var curLib: [String]?
    
    override func loadView() {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Category == "FoodSegue" {
            curLib = foodLib
        }
        if Category == "OutdoorSegue" {
            curLib = outdoorLib
        }
        if Category == "HistorySegue" {
            curLib = historyLib
        }
        if Category == "SouvenirSegue" {
            curLib = souvenirLib
        }
        if Category == "EntertainmentSegue" {
            curLib = entertainmentLib
        }
        if Category == "ShoppingSegue" {
            curLib = shoppingLib
        }
        if Category == "SportSegue" {
            curLib = sportLib
        }
        if Category == "NatureSegue" {
            curLib = natureLib
        }
        
        let camera = GMSCameraPosition.camera(withLatitude:lat,
                                              longitude:longt,
                                              zoom:12)
        
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView?.delegate = self
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: longt)
        marker.title = "ss"
        marker.snippet = "ss"
        marker.map = mapView

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView:GMSMapView, didTapAt coordinate:CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    func updataMap() {
        
        if Category == "FoodSegue" {
            curLib = foodLib
        }
        if Category == "OutdoorSegue" {
            curLib = outdoorLib
        }
        if Category == "HistorySegue" {
            curLib = historyLib
        }
        if Category == "SouvenirSegue" {
            curLib = souvenirLib
        }
        if Category == "EntertainmentSegue" {
            curLib = entertainmentLib
        }
        if Category == "ShoppingSegue" {
            curLib = shoppingLib
        }
        if Category == "SportSegue" {
            curLib = sportLib
        }
        if Category == "NatureSegue" {
            curLib = natureLib
        }
        
        let camera = GMSCameraPosition.camera(withLatitude:lat,
                                              longitude:longt,
                                              zoom:12)
        
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView?.delegate = self
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: longt)
        marker.title = "ss"
        marker.snippet = "ss"
        marker.map = mapView
        
        placeAutocomplete(lib: curLib!)
    }
    
    func placeAutocomplete(lib: [String]) {
        
        //        let bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: centerLat! - 50, longitude: centerLont! - 50), coordinate: CLLocationCoordinate2D(latitude: centerLat! + 50, longitude: centerLont! + 50))
        
        let visibleRegion = mapView?.projection.visibleRegion()
        
        let bounds = GMSCoordinateBounds(coordinate: (visibleRegion?.farLeft)!, coordinate: (visibleRegion?.nearRight)!)
        
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        
        var placesClient = GMSPlacesClient.shared()

        for l in lib {
            placesClient.autocompleteQuery(l, bounds: bounds, filter: filter, callback: {(results, error) -> Void in
                if let error = error {
                    print("Autocomplete error \(error)")
                    return
                }
                if let results = results {
                    for result in results {
                        let place = placesClient.lookUpPlaceID(result.placeID!, callback: { (gmsplace, error) in
                            let lat = gmsplace?.coordinate.latitude
                            let longt = gmsplace?.coordinate.longitude
                            
                            let marker = GMSMarker()
                            marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: longt!)
                            marker.title = result.attributedPrimaryText.string
//                            print(result.attributedPrimaryText.string)
                            marker.snippet = result.placeID
//                            print(result.placeID)
                            marker.map = self.mapView
                            
                        }
                        )
                        
                    }
                }
            })
        }
    }
    
    func mapView(_ mapView:GMSMapView, willMove gesture:Bool) {
        mapView.clear()
//        inViewList.removeAll()
    }
    
    func mapView(_ mapView:GMSMapView, idleAt cameraPosition:GMSCameraPosition) {
//        let geocoder = GMSGeocoder()
//
//        geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
//            guard error == nil else {
//                return
//            }
//
//            if let result = response?.firstResult() {
//                let marker = GMSMarker()
//                marker.position = cameraPosition.target
//                marker.title = result.lines?[0]
//                marker.snippet = result.lines?[1]
//                marker.map = mapView
//            }
//        }
        let lat = cameraPosition.target.latitude
        let longt = cameraPosition.target.longitude
        
        self.lat = lat
        self.longt = longt
        
        placeAutocomplete(lib: curLib!)
        
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
