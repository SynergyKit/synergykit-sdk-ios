//
//  BrandButton.swift
//  sampleapp
//
//  Created by Jan Čislinský on 25/03/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//
import UIKit


class BrandButton: UIButton {
    
    let animationDuration = 0.2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        backgroundColor = Colors.brand
        self.layer.cornerRadius = 4.0
        self.titleLabel!.font = UIFont.systemFontOfSize(15.0)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            if newValue
            {
                UIView.animateWithDuration(animationDuration, animations: {
                    () -> Void in
                    self.backgroundColor = Colors.brand.colorWithAlphaComponent(0.8)
                })
            }
            else
            {
                UIView.animateWithDuration(animationDuration, animations: {
                    () -> Void in
                    self.backgroundColor = Colors.brand
                })
                
            }
            super.highlighted = newValue
        }
    }
    
    override var enabled: Bool {
        didSet {
            if self.enabled
            {
                UIView.animateWithDuration(animationDuration, animations: {
                    () -> Void in
                    self.backgroundColor = Colors.brand
                })
            }
            else
            {
                UIView.animateWithDuration(animationDuration, animations: {
                    () -> Void in
                    self.backgroundColor = Colors.brand.colorWithAlphaComponent(0.5)
                })
            }
        }
    }
}
