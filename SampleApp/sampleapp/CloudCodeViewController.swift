//
//  CloudCodeViewController.swift
//  sampleapp
//
//  Created by Jan Čislinský on 15/01/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class CloudCodeViewController: SuperViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate {

    var textField : UITextField!
    var imageView : UIImageView!
    var textView : UITextView!
    var blurEffectView : UIVisualEffectView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Cloud Code"
        setupContent()
    }

    func setupContent()
    {
        let contentWidth : CGFloat = viewWidth-2*Dimensions.MARGIN_LEFT
        let marginTop : CGFloat = Dimensions.MARGIN_LEFT
        
        // Send notification
        textField = TextField(frame: CGRectMake(Dimensions.MARGIN_LEFT, marginTop, round(contentWidth*0.65)-5.0, 44.0))
        
        textField.delegate = self
        textField.placeholder = "Name of the subject"
        
        let sendButton = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT+round(contentWidth*0.65)+5.0, marginTop, round(contentWidth*0.35)-5.0, 44.0))
        
        sendButton.addTarget(self, action: "uploadButtonPress:", forControlEvents: .TouchUpInside)
        sendButton.setTitle("Select", forState: .Normal)
        
        let divider = self.divider(lastView: sendButton)
        view.layer.addSublayer(divider)
        
        view.addSubview(textField)
        view.addSubview(sendButton)
        
        let height : CGFloat = view.frame.size.height-CGRectGetMaxY(divider.frame)-2*Dimensions.MARGIN_LEFT
        
        imageView = UIImageView(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(divider.frame)+Dimensions.MARGIN_LEFT, contentWidth, height))
        view.addSubview(imageView)
        
        imageView.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).CGColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 2.0
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill

    }
    
    func showImageDescription(result : CloudCodeDemo)
    {
        if textView != nil { textView.removeFromSuperview() }
        
        let textViewHeight : CGFloat = 100.0
        textView = UITextView(frame: CGRectMake(0.0, 0.0, imageView.frame.size.width-Dimensions.MARGIN_LEFT, textViewHeight))
        textView.backgroundColor = UIColor.clearColor()
        textView.textAlignment = .Center
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRectMake(1.5*Dimensions.MARGIN_LEFT, CGRectGetMaxY(imageView.frame)-textViewHeight-Dimensions.MARGIN_LEFT/2.0, imageView.frame.size.width-Dimensions.MARGIN_LEFT, textViewHeight)
       
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = blurEffectView.bounds
        
        blurEffectView.contentView.addSubview(vibrancyEffectView)
        vibrancyEffectView.contentView.addSubview(textView)
        
        view.addSubview(blurEffectView)
        
        textView.text = (result.error != nil && count(result.error) > 0) ? "\(textField.text)\n\(result.error)" : "\(textField.text)\ngender: \(result.gender) (\(result.genderConfidence) %)\nage: \(result.age) +/-\(result.ageRange)\nglass: \(result.glass)\nrace: \(result.race) (\(result.raceConfidence) %)\nsmiling: \(result.smiling) %"
        textField.text = ""
        blurEffectView.alpha = 0
        
        UIView.animateWithDuration(0.5, animations: {
            () -> Void in
            self.blurEffectView.alpha = 1.0
        })
    }
    
    func uploadButtonPress(sender : UIButton)
    {
        view.endEditing(true)
        if count(textField.text) > 0
        {
            showPhotoInputSelection()
            textField.placeholder = "Name of the subject"
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Type name of the person whose face will be analyzed.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        view.endEditing(true)
        return true
    }
    
    // #############################################################################
    //MARK: Take a picture
    
    func showPhotoInputSelection()
    {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Camera", "Library")
        actionSheet.showInView(view)
    }

    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int)
    {
        if buttonIndex == actionSheet.cancelButtonIndex
        {
            // Cancel button
            return
        }
        
        var photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        
        if buttonIndex == 1
        {
            photoPicker.sourceType = .Camera
        }
        else if buttonIndex == 2
        {
            photoPicker.sourceType = .PhotoLibrary
        }
        
        navigationController!.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            HUD.showUIBlockingIndicator()
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
            UIView.animateWithDuration(0.5, animations: {
                () -> Void in
                if self.blurEffectView != nil { self.blurEffectView.alpha = 0.0 }
            })
            return
        })
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        uploadImageAndRecognize(image)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        picker .dismissViewControllerAnimated(true, completion: {
            () -> Void in
            HUD.showUIBlockingIndicator()
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
            UIView.animateWithDuration(0.5, animations: {
                () -> Void in
                if self.blurEffectView != nil { self.blurEffectView.alpha = 0.0 }
            })
            return
        })
        
        imageView.image = image
        uploadImageAndRecognize(image)
    }
    
    func uploadImageAndRecognize(image : UIImage)
    {
        SFile().uploadJPEGImage(UIImageJPEGRepresentation(image, 1.0), handler: {
            (result : SResponse!) -> Void in
            if result.succeeded()
            {
                SCloudCode(name: "face-recognition", args: ["path": (result.result as! SFile).path, "name": self.textField.text], resultType: CloudCodeDemo.self).invoke {
                    (result : SResponse!) -> Void in
                    HUD.hideUIBlockingIndicator()
                    if result.succeeded()
                    {
                        self.showImageDescription(result.result as! CloudCodeDemo)
                    }
                    else
                    {
                        var object = CloudCodeDemo()
                        object.error = (result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String
                        self.showImageDescription(object)
                    }
                }
            }
            else
            {
                // Error
                HUD.hideUIBlockingIndicator()
                var object = CloudCodeDemo()
                object.error = ((result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
                self.showImageDescription(object)
            }
        })
    }
    
}
