//
//  MapViewControllerRefactored.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 18/12/22.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet private weak var mapView: MGLMapView!
    
    @IBOutlet private weak var locationsCollectionView: UICollectionView!
    
    private let pointsDataSource = PointsDataSource()
    
    private var annotationViews = [MGLAnnotationView]()
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        pointsDataSource.navigationController = navigationController
        pointsDataSource.onFetchPositions = { [weak self] in
            self?.setupMapView()
        }
        
    }
    
    private func setupCollectionView() {
        locationsCollectionView.delegate = self
        locationsCollectionView.dataSource = pointsDataSource
        locationsCollectionView.register(UINib.init(nibName: "LocationDetailCell", bundle: nil), forCellWithReuseIdentifier: "LocationDetailCell")
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsUserHeadingIndicator = true
        mapView.addAnnotations(pointsDataSource.getMapAnnotations())
    }
}

extension MapViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        mapView.setCenter(annotation.coordinate, animated: true)
        
        if annotation is MGLPointAnnotation {
            if let previouslySelectedIndex = pointsDataSource.setMapPointSelected(with: annotation.coordinate) {
                locationsCollectionView.reloadItems(at: [IndexPath(item: previouslySelectedIndex, section: 0)])
            }
            let indexPath = IndexPath(item: pointsDataSource.getMapPointIndex(for: annotation.coordinate), section: 0)
            locationsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            locationsCollectionView.reloadItems(at: [indexPath])
        }
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        if annotation is MGLPointAnnotation {
            let reuseIdentifier = "\(annotation.coordinate.longitude)"
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) {
                return annotationView
            }
            let annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: "\(annotation.coordinate.longitude)")
            annotationView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            annotationView.bounds = annotationView.frame
            annotationViews.append(annotationView)
            return annotationView
        }
        return nil
    }
    
}

extension MapViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if pointsDataSource.mapPoint(for: indexPath.row).isSelected {
            return CGSize(width: 200, height: 250)
        }
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previouslySelectedIndex = pointsDataSource.setMapPointSelected(with: indexPath.row) {
            annotationViews[previouslySelectedIndex].setSelected(false, animated: true)
            collectionView.reloadItems(at: [IndexPath(item: previouslySelectedIndex, section: 0)])
        }
        let mapPoint = pointsDataSource.mapPoint(for: indexPath.row)
        let coordinate = CLLocationCoordinate2D(latitude: mapPoint.location.latitude, longitude: mapPoint.location.longitude)
        mapView.setCenter(coordinate, animated: true)
        annotationViews[indexPath.row].setSelected(true, animated: true)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadItems(at: [indexPath])
    }
}
