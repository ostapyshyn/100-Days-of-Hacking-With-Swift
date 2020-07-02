//
//  ViewController.swift
//  Project16
//
//  Created by Volodymyr Ostapyshyn on 01.07.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change Map Style", style: .plain, target: self, action: #selector(selectMap))
        
//        mapView.addAnnotation(london)
//        mapView.addAnnotation(oslo)
//        mapView.addAnnotation(paris)
//        mapView.addAnnotation(rome)
//        mapView.addAnnotation(washington)
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    
    @objc func selectMap() {
        let alertController = UIAlertController(title: "Map Display Type", message: "How would you like to display the map?", preferredStyle: .actionSheet)
        
        let alertAction1 = UIAlertAction(title: "Satellite", style: .default) { (alertAction) in
            self.mapView.mapType = .satellite
        }
        let alertAction2 = UIAlertAction(title: "Hybrid", style: .default) { (alertAction) in
            self.mapView.mapType = .hybrid
        }
        let alertAction3 = UIAlertAction(title: "Standard", style: .default) { (alertAction) in
            self.mapView.mapType = .standard
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        alertController.addAction(alertAction3)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Capital else { return nil }

        // 2
        let identifier = "Capital"

        // 3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        

        if annotationView == nil {
            //4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = .purple
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        //let placeInfo = capital.info
        
        let vc = webVC()
        
        switch placeName {
        case "London":
            vc.site = "https://en.wikipedia.org/wiki/London"
        case "Paris":
            vc.site = "https://en.wikipedia.org/wiki/Paris"
        case "Oslo":
            vc.site = "https://en.wikipedia.org/wiki/Oslo"
        case "Rome":
            vc.site = "https://en.wikipedia.org/wiki/Rome"
        case "Washington DC":
            vc.site = "https://en.wikipedia.org/wiki/Washington,_D.C."
        default:
            break
        }
        
        navigationController?.pushViewController(vc, animated: true)
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
    }


}

