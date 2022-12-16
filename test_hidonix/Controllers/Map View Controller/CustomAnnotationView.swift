//
//  CustomAnnotationView.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 16/12/22.
//

import UIKit
import Mapbox

class CustomAnnotationView: MGLAnnotationView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.red.cgColor
    }

}
