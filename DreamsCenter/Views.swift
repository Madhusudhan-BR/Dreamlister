//
//  Views.swift
//  DreamsCenter
//
//  Created by Madhusudhan B.R on 6/7/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import UIKit

private var materialBool = false

extension UIView {
    @IBInspectable var Material : Bool {
        get {
            return materialBool
        }
        set {
            materialBool = newValue
            
            if materialBool {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 5
                self.layer.shadowOpacity = 0.9
                self.layer.shadowRadius = 5
                self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 245/255, green: 92/255, blue: 103/255, alpha: 1).cgColor
            }else {
                self.layer.shadowOpacity = 0.0
                self.layer.shadowRadius = 0
                self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
                self.layer.shadowColor = nil
            }
            
        }
        
    
    }
}
