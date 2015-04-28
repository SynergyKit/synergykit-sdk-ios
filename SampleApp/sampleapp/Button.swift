//
//  Button.swift
//  sampleapp
//
//  Created by Jan Čislinský on 25/03/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//
import UIKit


class Button: UIButton {
    
    let animationDuration = 0.2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor(white: 0.3, alpha: 1.0), forState: .Normal)
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
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
                    self.backgroundColor = UIColor(white: 0.83, alpha: 1.0)
                })
            }
            else
            {
                UIView.animateWithDuration(animationDuration, animations: {
                    () -> Void in
                    self.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
                })
                
            }
            super.highlighted = newValue
        }
    }
}
