//
//  ChatView.swift
//  sampleapp
//
//  Created by Jan Čislinský on 20/04/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

enum BubblePosition: Int
{
    case Left, Right, Center
}

class ChatView: UIScrollView {

    var lastBubbleBottomY : CGFloat = 0
    let bubbleMarginBottom : CGFloat = 10.0
    let avatarMargin : CGFloat = 7.0
    let avatarHeight : CGFloat = 36.0
    let messageWidth : CGFloat = 0.75
    let messageTopPadding : CGFloat = 9.0
    let messageLeftPadding : CGFloat = 8.0
    
    struct TextBubble {
        var message : String!
        var author : String?
        var position : BubblePosition!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentInset = UIEdgeInsetsMake(frame.size.height, 0.0, 0.0, 0.0)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addBubble(bubble : TextBubble)
    {
        let marginLeft : CGFloat = 8
        let contentWidth : CGFloat = frame.size.width-2*marginLeft
        
        let bubbleView = UIView(frame: CGRectMake(marginLeft, lastBubbleBottomY+bubbleMarginBottom, contentWidth, 0.0))
        addSubview(bubbleView)
        
        let color = bubble.position == .Right ? Colors.brand : UIColor(white: 0.3, alpha: 1.0)
        
        
        // Avatar
        if bubble.position != .Center
        {
            let avatarLeft : CGFloat = bubble.position == .Right ? contentWidth-avatarHeight : 0
            let avatar = UITextField(frame: CGRectMake(avatarLeft, 0.0, avatarHeight, avatarHeight))
            bubbleView.addSubview(avatar)
            
            avatar.backgroundColor = color
            avatar.font = UIFont.systemFontOfSize(avatarHeight/2.0)
            avatar.textColor = UIColor(white: 0.95, alpha: 1.0)
            avatar.textAlignment = .Center
            avatar.layer.cornerRadius = avatarHeight/2.0
            avatar.enabled = false
            avatar.text = "?"
            
            if let a = bubble.author
            {
                avatar.text = ""
                let names = split(a) {$0 == " "}
                for name in names as [String]
                {
                    let index : String.Index = advance(name.startIndex, 1)
                    avatar.text = avatar.text + name.substringToIndex(index).uppercaseString
                }
            }
        }
        
        // Message
        let textWidth = contentWidth-2*(avatarHeight+avatarMargin)
        let message = UITextView(frame: CGRectMake(avatarHeight+avatarMargin, 0.0, textWidth*messageWidth, avatarHeight))
        bubbleView.addSubview(message)
        
        message.backgroundColor = color.colorWithAlphaComponent(0.15)
        message.editable = false
        message.textContainerInset = UIEdgeInsetsMake(messageTopPadding, messageLeftPadding, messageTopPadding, messageLeftPadding)
        message.layer.cornerRadius = avatarHeight/2.0
        message.font = UIFont.systemFontOfSize(bubble.position == .Center ? 10 : 14)
        message.scrollEnabled = false
        message.text = bubble.message
        
        if bubble.position == .Center
        {
            message.backgroundColor = UIColor.clearColor()
            message.layer.borderWidth = 1.0
            message.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).CGColor
            message.textContainerInset = UIEdgeInsetsMake(messageTopPadding+2, messageLeftPadding, messageTopPadding+2, messageLeftPadding)
            message.textColor = UIColor(white: 0.6, alpha: 1.0)
        }
        
        // Message positioning
        let fixedWidth : CGFloat = message.frame.size.width;
        let newSize : CGSize = message.sizeThatFits(CGSizeMake(fixedWidth, CGFloat(MAXFLOAT)))
        var newFrame : CGRect = message.frame;
        newFrame.size = CGSizeMake(CGFloat(fminf(Float(newSize.width), Float(fixedWidth))), newSize.height)
        if bubble.position == .Right
        {
            newFrame.origin.x = avatarHeight+avatarMargin + textWidth*(1-messageWidth) + (textWidth*messageWidth-newFrame.size.width)
        }
        message.frame = newFrame;
        if bubble.position == .Center
        {
            message.center = CGPointMake(contentWidth/2.0, message.center.y)
        }
        
        // Bubble size
        var bubbleViewFrame = bubbleView.frame
        bubbleViewFrame.size.height = message.frame.size.height
        bubbleView.frame = bubbleViewFrame
        
        // View adjusments
        lastBubbleBottomY = CGRectGetMaxY(bubbleView.frame)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 40, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            () -> Void in
            
            if (self.frame.size.height-self.lastBubbleBottomY-self.bubbleMarginBottom) > 0
            {
                self.contentInset = UIEdgeInsetsMake(self.frame.size.height-self.lastBubbleBottomY-self.bubbleMarginBottom, 0.0, 0.0, 0.0)
                self.contentOffset = CGPointZero
            }
            else
            {
                self.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
                self.contentOffset = CGPointMake(0.0, -1*(self.frame.size.height-self.lastBubbleBottomY-self.bubbleMarginBottom))
            }
            
            self.contentSize = CGSizeMake(1.0, self.lastBubbleBottomY+self.bubbleMarginBottom)
            
        }) {
            (finished : Bool) -> Void in

        }
    }
    
    func repositionToSize(size : CGSize)
    {
        var newFrame = frame
        newFrame.size = size
        frame = newFrame
        
        if (newFrame.size.height-lastBubbleBottomY-bubbleMarginBottom) > 0
        {
            contentInset = UIEdgeInsetsMake(frame.size.height-lastBubbleBottomY-bubbleMarginBottom, 0.0, 0.0, 0.0)
        }
        else
        {
            contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
            contentOffset = CGPointMake(0.0, -1*(frame.size.height-lastBubbleBottomY-bubbleMarginBottom))
        }

        
    }
    
    
}
