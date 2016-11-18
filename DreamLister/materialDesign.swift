//
//  materialDesign.swift
//  DreamLister
//
//  Created by Shashank Kannam on 10/23/16.
//  Copyright © 2016 Shashank Kannam. All rights reserved.
//

import Foundation
import UIKit

private var materialKey = false

extension UIView{
    
    @IBInspectable var materialDesign:Bool {
        get{
            return materialKey
        }
        set{
            materialKey = true
            
            if materialKey{
              layer.masksToBounds = false
              layer.cornerRadius = 3.0
                layer.shadowRadius = 3.0
                layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                layer.shadowOpacity = 0.8
                layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 0.1).cgColor
            }
            else{
                layer.cornerRadius = 0.0
                layer.shadowRadius = 0.0
                layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                layer.shadowOpacity = 0.0
                layer.shadowColor = nil
            }
        }
    }
    
}
