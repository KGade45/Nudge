//
//  GradientView.swift
//  Nudge
//
//  Created by Harshal Dhawad on 18/12/25.
//


import Foundation
import UIKit

class GradientView {
    private let view: UIView
    private let primaryColor: UIColor
    private let secondaryColor: UIColor
    init(view: UIView, primaryColor: UIColor, secondaryColor: UIColor) {
        self.view = view
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    func getGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer(layer: view.layer)
        gradient.colors = [primaryColor.cgColor, secondaryColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0, 0.2]
        gradient.frame = view.bounds
  
        return gradient
    }
}
