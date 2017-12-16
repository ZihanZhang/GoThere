//
//  DetailViewController.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/15.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import GooglePlacePicker

class DetailViewController: UIViewController, GMSMapViewDelegate {
    
    var mapView:GMSMapView?
    var Category: String?
    var Location: String?
    
    let geoCoder = CLGeocoder()
    var placesClient: GMSPlacesClient!
    let geocoder = GMSGeocoder()
    
    var centerLat: Double?
    var centerLont: Double?
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        
        placeAutocomplete()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let rightButtonItem = UIBarButtonItem.init(
            title: "Title",
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        placesClient = GMSPlacesClient.shared()
        
        geoCoder.geocodeAddressString(Location!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            
            let lat = location.coordinate.latitude
            let longt = location.coordinate.longitude
            
            self.centerLat = lat
            self.centerLont = longt
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: longt, zoom: 12.0)
            let mapFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1/3 * UIScreen.main.bounds.height)
            self.mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
            self.mapView?.isMyLocationEnabled = true
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: longt)
            marker.title = self.Location
            marker.snippet = self.Location
            marker.map = self.mapView
            
            self.placeAutocomplete()
            
//            self.mapView?.animate(toZoom: 12)
            
            self.view.addSubview(self.mapView!)
        }

        // Do any additional setup after loading the view.
    }
    
    func placeAutocomplete() {
        
//        let bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: centerLat! - 50, longitude: centerLont! - 50), coordinate: CLLocationCoordinate2D(latitude: centerLat! + 50, longitude: centerLont! + 50))
        
        let visibleRegion = mapView?.projection.visibleRegion()
        
        let bounds = GMSCoordinateBounds(coordinate: (visibleRegion?.farLeft)!, coordinate: (visibleRegion?.nearRight)!)
    
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        placesClient.autocompleteQuery("Coffee", bounds: bounds, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                for result in results {
                    let place = self.placesClient.lookUpPlaceID(result.placeID!, callback: { (gmsplace, error) in
                        let lat = gmsplace?.coordinate.latitude
                        let longt = gmsplace?.coordinate.longitude
                        
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: longt!)
                        marker.title = self.Location
                        marker.snippet = self.Location
                        marker.map = self.mapView
                        }
                    )

                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView:GMSMapView, willMove gesture:Bool) {
        mapView.clear()
    }
    
    func mapView(_ mapView:GMSMapView, idleAt cameraPosition:GMSCameraPosition) {
        geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
            guard error == nil else {
                return
            }
            
            if let result = response?.firstResult() {
                let marker = GMSMarker()
                marker.position = cameraPosition.target
                print(cameraPosition.target.latitude)
                print(cameraPosition.target.longitude)
                marker.title = result.lines?[0]
                marker.snippet = result.lines?[1]
                marker.map = mapView
                
                self.view.subviews[0].removeFromSuperview() // this gets things done
                
                self.view.addSubview(mapView)
            }
        }
    }
    
    func mapView(_ mapView:GMSMapView, didTapAt coordinate:CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
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
