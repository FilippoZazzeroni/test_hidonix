//
//  PointsDataSource.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 17/12/22.
//

import Foundation
import UIKit
import Mapbox

struct MapPoint {
    let location: Location
    var isSelected = false
}

class PointsDataSource: NSObject {
    
    
    //MARK: Properties
    
    private var mapPoints = [MapPoint]()
    
    var navigationController: UINavigationController?
    
    var onFetchPositions: (() -> Void)! {
        didSet {
            LocationApi().getAllPositions {[weak self] locations in
                for location in locations {
                    self?.mapPoints.append(MapPoint(location: location))
                }
                self?.onFetchPositions()
            }
        }
    }
    
    //MARK: Methods
    
    func getMapAnnotations() -> [MGLPointAnnotation] {
        var annotations = [MGLPointAnnotation]()
        for point in mapPoints {
            let annotation = MGLPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: point.location.latitude, longitude: point.location.longitude)
            annotations.append(annotation)
        }
        return annotations
    }
    
    /// Returns the index of the previously selected item
    func setMapPointSelected(with coordinate: CLLocationCoordinate2D) -> Int? {
        var previouslySelectedItem: Int?
        for index in 0..<mapPoints.count {
            if mapPoints[index].isSelected {
                previouslySelectedItem = index
            }
            if mapPoints[index].location.latitude == coordinate.latitude && mapPoints[index].location.longitude == coordinate.longitude {
                mapPoints[index].isSelected = true
            } else {
                mapPoints[index].isSelected = false
            }
        }
        return previouslySelectedItem
    }
    
    /// Returns the index of the previously selected item
    func setMapPointSelected(with index: Int) -> Int? {
        var previouslySelectedItem: Int?
        for i in 0..<mapPoints.count {
            if mapPoints[i].isSelected {
                previouslySelectedItem = i
            }
            if i != index {
                mapPoints[i].isSelected = false
            } else {
                mapPoints[i].isSelected = true
            }
        }
        return previouslySelectedItem
    }
    
    func getMapPointIndex(for coordinate: CLLocationCoordinate2D) -> Int {
        return mapPoints.firstIndex { point in
            return point.location.latitude == coordinate.latitude && point.location.longitude == coordinate.longitude
        }!
    }
    
    func getMapPointSelectedIndex() -> Int? {
        return mapPoints.firstIndex { point in
            return point.isSelected
        }
    }
    
    func mapPoint(for index: Int) -> MapPoint {
        return mapPoints[index]
    }
    
    func getLocations() -> [Location] {
        return mapPoints.map { $0.location }
    }
    
}

extension PointsDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapPoints.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let point = mapPoints[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationDetailCell", for: indexPath) as! LocationDetailCell
        cell.title.text = point.location.name
        cell.subTitle.text = point.location.address ?? ""
        cell.onDetailButtonPressedCallback = { [weak self] in
            self?.onPressedDetailLocationCell(with: point.location)
        }
        cell.isCellSelected = mapPoints[indexPath.row].isSelected
        if cell.backgroundImage.image != nil {
            ImageDownloader().getImageFrom(url: URL(string: point.location.imageThumbnail)!) { data in
                DispatchQueue.main.async {
                    cell.backgroundImage.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
    private func onPressedDetailLocationCell(with location: Location) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "LocationDetailViewController") as! LocationDetailViewController
        detailViewController.location = location
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
