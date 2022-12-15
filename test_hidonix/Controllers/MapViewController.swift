//
//  ViewController.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 15/12/22.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {
    
    
   
    // MARK: Properties
    
    @IBOutlet weak var mapView: MGLMapView!
    
    private let dummyPoints = [
        CLLocationCoordinate2D(latitude: 37.5389733388, longitude: 15.1312623918),
        CLLocationCoordinate2D(latitude: 37.5389733388 , longitude: 15.1312623918),
        CLLocationCoordinate2D(latitude: 37.5747261972815, longitude: 15.1315106389223)
    ]
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        var annotations = [MGLPointAnnotation]()
        for point in dummyPoints {
            let annotation = MGLPointAnnotation()
            annotation.coordinate = point
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }
    
    
}

extension MapViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        mapView.setCenter(annotation.coordinate, animated: true)
    }
    
}


