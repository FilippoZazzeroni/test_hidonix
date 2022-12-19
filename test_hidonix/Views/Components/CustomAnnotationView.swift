//
//  CustomAnnotationView.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 16/12/22.
//

import UIKit
import Mapbox

class CustomAnnotationView: MGLAnnotationView {
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 4
        layer.borderColor = UIColor.red.cgColor
        layer.backgroundColor = UIColor.white.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        layer.backgroundColor = selected ? UIColor.green.cgColor : UIColor.white.cgColor
        layer.borderColor = selected ? UIColor.white.cgColor : UIColor.red.cgColor
    }

}
