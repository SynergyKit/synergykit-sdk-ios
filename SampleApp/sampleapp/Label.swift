//
//  Label.swift
//  sampleapp
//
//  Created by Jan Čislinský on 25/03/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class Label: UILabel {

    override init(frame: CGRect) {
        super.init(frame:frame)
        self.textAlignment = .Center
        self.font = UIFont.systemFontOfSize(11.0)
        self.textColor = UIColor(white: 0.6, alpha: 1.0)

    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
