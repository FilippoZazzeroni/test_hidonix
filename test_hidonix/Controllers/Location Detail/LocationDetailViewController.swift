//
//  LocationDetailViewController.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 17/12/22.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet private weak var image: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var categoryLabel: UILabel!
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var addressLabel: UILabel!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var location: Location!
    
    //MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        ImageDownloader().getImageFrom(url: URL(string:location.image)!) { [weak self] data in
            DispatchQueue.main.async {
                self?.image.image = UIImage(data: data)
                self?.activityIndicator.stopAnimating()
            }
        }
        nameLabel.text = location.name
        addressLabel.text = location.address
        descriptionLabel.text = location.description
        var categoryText = "Categoria: "
        location.categories.forEach { category in
            categoryText += "\(category.name) "
        }
        categoryLabel.text = categoryText
    }

}
