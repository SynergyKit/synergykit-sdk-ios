//
//  FilesViewController
//  sampleapp
//
//  Created by Jan Čislinský on 15/01/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class FilesViewController: SuperViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate {
    
    var textView : UITextView!
    var fileIndex = 0;
    var lastFile : SFile?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Files"
        setupContent()
    }
    
    func setupContent()
    {
        let contentWidth : CGFloat = viewWidth-2*Dimensions.MARGIN_LEFT
        let marginTop : CGFloat = Dimensions.MARGIN_LEFT
        
        let uploadImage = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, marginTop, contentWidth, 44.0))

        uploadImage.addTarget(self, action: "uploadImageButtonPress:", forControlEvents: .TouchUpInside)
        uploadImage.setTitle("Upload image or movie", forState: .Normal)
        
//        let uploadFiles = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(uploadImage.frame)+Dimensions.MARGIN_LEFT, contentWidth, 44.0))
        let uploadFiles = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, marginTop, contentWidth, 44.0))

        uploadFiles.addTarget(self, action: "uploadFilesButtonPress:", forControlEvents: .TouchUpInside)
        uploadFiles.setTitle("Upload file from bundle", forState: .Normal)
        
        let fetch = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(uploadFiles.frame)+Dimensions.MARGIN_LEFT, (contentWidth-Dimensions.MARGIN_LEFT)/2.0, 44.0))
        
        fetch.addTarget(self, action: "fetchButtonPress:", forControlEvents: .TouchUpInside)
        fetch.setTitle("Fetch last one", forState: .Normal)
        
        let destroy = Button(frame: CGRectMake(1.5*Dimensions.MARGIN_LEFT+contentWidth/2.0, CGRectGetMaxY(uploadFiles.frame)+Dimensions.MARGIN_LEFT, (contentWidth-Dimensions.MARGIN_LEFT)/2.0, 44.0))
        
        destroy.addTarget(self, action: "destroyButtonPress:", forControlEvents: .TouchUpInside)
        destroy.setTitle("Destroy last one", forState: .Normal)
        
        let divider = self.divider(lastView: fetch)
        view.layer.addSublayer(divider)
        
//        view.addSubview(uploadImage)
        view.addSubview(uploadFiles)
        view.addSubview(fetch)
        view.addSubview(destroy)
        
        let height : CGFloat = view.frame.size.height-CGRectGetMaxY(divider.frame)-2*Dimensions.MARGIN_LEFT
        textView = TextView(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(divider.frame)+Dimensions.MARGIN_LEFT, contentWidth, height))
        view.addSubview(textView)
    }
    
    func uploadImageButtonPress(sender : UIButton)
    {
        showPhotoInputSelection()
    }
    
    func uploadFilesButtonPress(sender : UIButton)
    {
        let bundle = NSBundle.mainBundle()
        
        let docx = bundle.pathForResource("test", ofType: "docx")!
        let doc = bundle.pathForResource("test", ofType: "doc")!
        let pdf = bundle.pathForResource("test", ofType: "pdf")!
        let txt = bundle.pathForResource("test", ofType: "txt")!
        let rtf = bundle.pathForResource("test", ofType: "rtf")!
        let html = bundle.pathForResource("test", ofType: "html")!
        let xlsx = bundle.pathForResource("test", ofType: "xlsx")!
        let xls = bundle.pathForResource("test", ofType: "xls")!
        let csv = bundle.pathForResource("test", ofType: "csv")!
    
        var testArray = [docx, doc, pdf, txt, rtf, html, xlsx, xls, csv]
        
        let fileUrlString = testArray[fileIndex]
        
        HUD.showUIBlockingIndicatorWithText("Uploading…")
        SFile().uploadFileOnPath(fileUrlString, handler: {
            (result : SResponse!) -> Void in
            HUD.hideUIBlockingIndicator()
            if result.succeeded()
            {
                UIPasteboard.generalPasteboard().string = (result.result as! SFile).path
                self.textView.text = "Link copied to pasteboard (" + (result.result as! SFile).path + ")"
                self.lastFile = (result.result as! SFile)
            }
            else
            {
                self.textView.text = ((result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
            }
        })
        
        if (fileIndex+1 == testArray.count)
        {
            fileIndex = 0;
        }
        else
        {
            fileIndex++
        }
    }
    
    func fetchButtonPress(sender : UIButton)
    {
        HUD.showUIBlockingIndicator()
        SQuery(object: SFile()).orderBy("createdAt", direction:.Desc).top(1).find {
            (results : SResponseWrapper!) -> Void in
            HUD.hideUIBlockingIndicator()
            
            if results.succeeded()
            {
                let file = results.results().first! as! SFile
                UIPasteboard.generalPasteboard().string = file.path
                self.textView.text = "Link copied to pasteboard (" + file.path + ")"
            }
            else
            {
                self.textView.text = (((results.errors().first! as! NSError).userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
            }
        }
    }
    
    func destroyButtonPress(sender : UIButton)
    {
        HUD.showUIBlockingIndicatorWithText("Destroying…")
        SQuery(object: SFile()).orderBy("createdAt", direction:.Desc).top(1).find {
            (results : SResponseWrapper!) -> Void in
            HUD.hideUIBlockingIndicator()
            
            if results.succeeded()
            {
                let file = results.results().first! as! SFile
                file.destroy {
                    (result : SResponse!) -> Void in
                    HUD.hideUIBlockingIndicator()
                    if result.succeeded()
                    {
                        self.textView.text = "Last file destroyed."
                        self.lastFile = nil
                    }
                    else
                    {
                        self.textView.text = ((result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
                    }
                }
            }
            else
            {
                self.textView.text = "Error: " + (((results.errors().first! as! NSError).userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
            }
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
        
        photoPicker.mediaTypes = [kUTTypeMovie, kUTTypeImage]
        
        navigationController!.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            HUD.showUIBlockingIndicatorWithText("Uploading…")
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
            return
        })
        
        if info[UIImagePickerControllerReferenceURL] != nil
        {
            // From library
            SFile().uploadFromAssetsLibrary(info[UIImagePickerControllerReferenceURL] as! NSURL, handler: {
                (result : SResponse!) -> Void in
                HUD.hideUIBlockingIndicator()
                if result.succeeded()
                {
                    UIPasteboard.generalPasteboard().string = result.result.path
                    self.textView.text = "Link copied to pasteboard (" + (info[UIImagePickerControllerReferenceURL] as! NSURL).pathExtension! + " extension)\n" + self.textView.text
                    self.lastFile = result.result as? SFile
                }
                else
                {
                    self.textView.text = "Error: " + result.error.description + "\n" + self.textView.text
                }
            })
        }
        else if info[UIImagePickerControllerMediaURL] != nil
        {
            // Captured video
            SFile().uploadFileOnURL(info[UIImagePickerControllerMediaURL] as! NSURL, handler: {
                (result : SResponse!) -> Void in
                HUD.hideUIBlockingIndicator()
                if result.succeeded()
                {
                    UIPasteboard.generalPasteboard().string = result.result.path
                    self.textView.text = "Link copied to pasteboard (" + (info[UIImagePickerControllerMediaURL] as! NSURL).pathExtension! + " extension)\n" + self.textView.text
                    self.lastFile = result.result as? SFile
                }
                else
                {
                    self.textView.text = "Error: " + result.error.description + "\n" + self.textView.text
                }
            })
        }
        else if info[UIImagePickerControllerOriginalImage] != nil
        {
            // Captured photo
            SFile().uploadJPEGImage(UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage, 1.0), handler: {
                (result : SResponse!) -> Void in
                HUD.hideUIBlockingIndicator()
                if result.succeeded()
                {
                    UIPasteboard.generalPasteboard().string = result.result.path
                    self.textView.text = "Link copied to pasteboard (jpg extension)\n" + self.textView.text
                    self.lastFile = result.result as? SFile
                }
                else
                {
                    self.textView.text = "Error: " + result.error.description + "\n" + self.textView.text
                }
            })
        }
    }
}
