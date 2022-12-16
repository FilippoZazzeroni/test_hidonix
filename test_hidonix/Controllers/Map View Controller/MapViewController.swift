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
    
    @IBOutlet private weak var mapView: MGLMapView!
    
    @IBOutlet private weak var locationsCollectionView: UICollectionView!
    
    private var dummyPoints = [
        DummyPoint(coordinate: CLLocationCoordinate2D(latitude: 37.5389733388, longitude: 15.1312623918)),
        DummyPoint(coordinate: CLLocationCoordinate2D(latitude: 37.5389733388 , longitude: 15.1312623918)),
        DummyPoint(coordinate: CLLocationCoordinate2D(latitude: 37.5747261972815, longitude: 15.1315106389223)),
        DummyPoint(coordinate: CLLocationCoordinate2D(latitude: 37.54 , longitude: 15.133)),
        DummyPoint(coordinate: CLLocationCoordinate2D(latitude: 37.58, longitude: 15.136))
    ]
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsCollectionView.delegate = self
        locationsCollectionView.dataSource = self
        locationsCollectionView.register(UINib.init(nibName: "LocationDetailCell", bundle: nil), forCellWithReuseIdentifier: "LocationDetailCell")
        mapView.delegate = self
        
        var annotations = [MGLPointAnnotation]()
        for point in dummyPoints {
            let annotation = MGLPointAnnotation()
            annotation.coordinate = point.coordinate
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
        
    }
}

extension MapViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        mapView.setCenter(annotation.coordinate, animated: true)
        let index = dummyPoints.firstIndex { point in
            return annotation.coordinate.latitude == point.coordinate.latitude
        }
        dummyPoints[index!].isSelected = true
        for index in 0..<dummyPoints.count {
            if dummyPoints[index].coordinate.latitude != annotation.coordinate.latitude {
                dummyPoints[index].isSelected = false
            }
        }
        locationsCollectionView.reloadData()
        locationsCollectionView.scrollToItem(at: IndexPath(item: index!, section: 0), at: .centeredHorizontally, animated: true)
        
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotationView: MGLAnnotationView) {
        print("selcted annotation view")
        annotationView.backgroundColor = .green
    }
    
}

extension MapViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyPoints.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationDetailCell", for: indexPath) as! LocationDetailCell
        
        cell.isCellSelected = dummyPoints[indexPath.row].isSelected
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if dummyPoints[indexPath.row].isSelected {
            return CGSize(width: 200, height: 280)
        }
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dummyPoints[indexPath.row].isSelected = true
        for index in 0..<dummyPoints.count {
            if index != indexPath.row {
                dummyPoints[index].isSelected = false
            }
        }
        mapView.setCenter(dummyPoints[indexPath.row].coordinate, animated: true)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
}


struct DummyPoint {
    let coordinate: CLLocationCoordinate2D
    var isSelected = false
}
