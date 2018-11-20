//
//  Extension.swift
//  Verifica_Luca_Bonin
//
//  Created by Leo Luca Bonin on 20/11/2018.
//  Copyright © 2018 developer.llb. All rights reserved.
//

import UIKit

extension UITextField {
    
    func roundBorder(radius : Int) {
        self.layer.cornerRadius = CGFloat(radius)
    }
}

extension UIButton {
    
    func roundBorder(radius : Int) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
    
    func circleButton(){
        self.layer.cornerRadius = self.frame.width / 4
        self.clipsToBounds = true
    }
    
}

extension UIImage {
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}




