//
//  TextField.swift
//  sampleapp
//
//  Created by Jan Čislinský on 26/03/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class TextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).CGColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 2.0
        self.returnKeyType = UIReturnKeyType.Done
        self.backgroundColor = UIColor.whiteColor()
        self.textAlignment = .Center
        self.font = UIFont.systemFontOfSize(13.0)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
