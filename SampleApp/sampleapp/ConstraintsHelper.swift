//
//  ConstrainsHelper.swift
//  KnowHow
//
//  Created by Jan Čislinský on 24/11/14.
//
//

import UIKit

class ConstraintsHelper
{
    class func centerXConstraint(#view : UIView, tumples : (object : UIView, centeredTo : UIView)...)
    {
        for tuple in tumples
        {
            view.addConstraint(NSLayoutConstraint(item: tuple.object, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: tuple.centeredTo, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        }
    }
    
    class func centerYConstraint(#view : UIView, tumples : (object : UIView, centeredTo : UIView)...)
    {
        for tuple in tumples
        {
            view.addConstraint(NSLayoutConstraint(item: tuple.object, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: tuple.centeredTo, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0))
        }
    }
    
    class func applyConstraints(#view : UIView!, metrics : Dictionary<String, Double>?, views : Dictionary<String, UIView!>!, constraints : Array<String>!)
    {
        for constraint in constraints
        {
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(constraint, options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views))
        }
    }
}
