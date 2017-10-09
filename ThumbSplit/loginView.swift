//
//  LoginView.swift
//  ThumbSplit
//
//  Created by Sierra on 9/25/17.
//  Copyright © 2017 Sierra. All rights reserved.
//

import UIKit

@IBDesignable class LoginView: UIView {

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}


