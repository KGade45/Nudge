//
//  PaddingLabel.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 14/12/25.
//

import UIKit

import UIKit

final class PaddingLabel: UILabel {

    var padding = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + padding.left + padding.right,
            height: size.height + padding.top + padding.bottom
        )
    }
}
