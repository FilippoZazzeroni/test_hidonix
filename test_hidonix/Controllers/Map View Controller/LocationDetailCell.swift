//
//  LocationDetailCell.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 15/12/22.
//

import UIKit

class LocationDetailCell: UICollectionViewCell {

    //MARK: Properties
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet private weak var titlesAndButtonContainerView: UIView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet private weak var detailButton: UIButton!
    
    var onDetailButtonPressedCallback: (() -> Void)?
    
    var isCellSelected = false {
        didSet {
            detailButton.isHidden = !isCellSelected
        }
    }
    
    //MARK: methods
    
    override func awakeFromNib() {
        backgroundImage.layer.cornerRadius = 20.0
        
        let bottomCornerRadiusPath = UIBezierPath(roundedRect: titlesAndButtonContainerView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20.0, height: 20.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = bottomCornerRadiusPath.cgPath
        
        titlesAndButtonContainerView.layer.mask = maskLayer
        titlesAndButtonContainerView.backgroundColor = titlesAndButtonContainerView.backgroundColor?.withAlphaComponent(0.7)
        
        detailButton.layer.borderColor = UIColor.white.cgColor
        detailButton.layer.borderWidth = 1.0
        detailButton.layer.cornerRadius = 15.0
        detailButton.isHidden = isCellSelected
        
    }
    
    
    @IBAction func onDetailButtonPressed() {
        onDetailButtonPressedCallback?()
    }
}
