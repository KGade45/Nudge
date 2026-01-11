//
//  UIVIew+Ext.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 11/01/26.
//

import Foundation
import UIKit
extension UIView {
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let vc = responder as? UIViewController {
                return vc
            }
        }
        return nil
    }
}
