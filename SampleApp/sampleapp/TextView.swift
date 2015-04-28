//
//  TextView.swift
//  sampleapp
//
//  Created by Jan Čislinský on 25/03/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class TextView: UITextView {

    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        self.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).CGColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 2.0
        self.returnKeyType = UIReturnKeyType.Done
        self.editable = false
        self.backgroundColor = UIColor.whiteColor()
        self.font = UIFont.systemFontOfSize(13.0)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
}
