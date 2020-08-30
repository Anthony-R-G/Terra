//
//  Utilities.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class Factory {
    static func makeLabel(
        title: String?,
        weight: FontWeight,
        size: CGFloat,
        color: UIColor,
        alignment: NSTextAlignment) -> UILabel {
        
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: weight.rawValue, size: size.deviceScaled)
        label.textAlignment = alignment
        label.textColor = color
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }
    
    static func makeDetailInfoWindowLabel(text: String) -> UILabel {
        let label = makeLabel(
            title: text.replacingOccurrences(of: "\\n", with: "\n"),
            weight: .regular,
            size: 16,
            color: .white,
            alignment: .natural)
        label.numberOfLines = 0
        return label
    }
    
        
    static func makeBlurredCircleButton(image: systemImage, style: ButtonStyle, size: ButtonSize ) -> CircleBlurButton {
        let size: CGSize = size == .regular ? CGSize(width: 35, height: 35) : CGSize(width: 30, height: 30)
        let button = CircleBlurButton(
            frame: CGRect(
                origin: .zero,
                size: size),
            
            image: UIImage(systemName: image.rawValue)!,
            style: style)
        
        button.snp.makeConstraints { (make) in
            make.height.width.equalTo(button.frame.size) }
        return button
    }
}

enum systemImage: String {
    case close = "xmark"
    case augmentedReality = "arkit"
    case list = "list.dash"
    case share = "square.and.arrow.up"
    case refresh = "arrow.clockwise"
}

enum ButtonSize {
    case small
    case regular
}



