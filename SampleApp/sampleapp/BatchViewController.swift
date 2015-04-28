//
//  BatchViewController.swift
//  sampleapp
//
//  Created by Jan Čislinský on 25/02/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

import UIKit

class BatchViewController: SuperViewController, UITextFieldDelegate {

    let COLLECTION_NAME = "demo-objects"
    let COLLECTION_NAME_INNER = "inner-objects"
    
    var textField : UITextField!
    var textView : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Batch"
        setupContent()
    }

    func setupContent()
    {
        let contentWidth : CGFloat = viewWidth-2*Dimensions.MARGIN_LEFT
        let marginTop : CGFloat = Dimensions.MARGIN_LEFT
        
        // POST
        textField = TextField(frame: CGRectMake(Dimensions.MARGIN_LEFT, marginTop, round(contentWidth*0.65)-5.0, 44.0))
        
        textField.delegate = self
        textField.placeholder = "Insert some text"
        
        let postButton = Button(frame: CGRectMake(Dimensions.MARGIN_LEFT+round(contentWidth*0.65)+5.0, marginTop, round(contentWidth*0.35)-5.0, 44.0))
        
        postButton.addTarget(self, action: "postButtonPress:", forControlEvents: .TouchUpInside)
        postButton.setTitle("BATCH", forState: .Normal)
        
        let divider = self.divider(lastView: postButton)
        view.layer.addSublayer(divider)
        
        view.addSubview(textField)
        view.addSubview(postButton)
        
        let height : CGFloat = view.frame.size.height-CGRectGetMaxY(divider.frame)-2*Dimensions.MARGIN_LEFT
        
        textView = TextView(frame: CGRectMake(Dimensions.MARGIN_LEFT, CGRectGetMaxY(divider.frame)+Dimensions.MARGIN_LEFT, contentWidth, height))
        view.addSubview(textView)
        
        textView.text = "You need to be Signed In.\nFor information about actions in batch request watch source code."
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        view.endEditing(true)
        return true
    }
    
    func postButtonPress(sender : UIButton)
    {
        if count(textField.text) > 0
        {
            view.endEditing(true)
            
            if let userId = NSUserDefaults.standardUserDefaults().objectForKey(StaticStrings.USER_ID) as? String
            {
                HUD.showUIBlockingIndicator()
                
                SQuery(object: DemoObject(collection: COLLECTION_NAME)).top(1).find {
                    (result : SResponseWrapper!) -> Void in
                    if result.succeeded()
                    {
                        self.batchRequest(result.results().first as! DemoObject)
                    }
                    else
                    {
                        self.textView.text = (((result.errors().first! as! NSError).userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
                        HUD.hideUIBlockingIndicator()
                    }
                }
            }
            else
            {
                let string = "Error: Sign In first!"
                self.textView.text = string
            }
        }
        else
        {
            self.textView.text = "Type something!"
        }
    }
    
    func batchRequest(object : DemoObject)
    {
        self.textView.text = ""
        
        let existingUserId = "3bae052b-b7b1-4d91-b5d8-571b09f5a9cd"
        let existingPlatformId = "46fae093-ac32-4b5d-90d6-e0857f928f3d"
        let existingFileId = "01759e3c-2de5-41e6-834b-d02443922550"
        let existingDemoObjectId = "14378140-9995-4f90-b0d1-f031c7c5e43d"
        
        // Prepares objects for batching
        let put = object
        put.text = self.textField.text
        
        let patch = DemoObject(text: "another string")
        patch._id = put._id
        patch.__v = NSNumber(int:put.__v.intValue+1)
        
        // Batch request response contains of separate response items according to request items. BatchResponseHandler handles every response item types.
        let batchResponseHandler = {
            (result : SResponse!) -> Void in
            if result.succeeded()
            {
                let resultResponse = result.result as! SBatchResponse // Result of one request item in batch
                
                if resultResponse.statusCode == 200
                {
                    // Request item succeeded
                    if resultResponse.requestItem.method == SMethodType.DELETE
                    {
                        // DELETE
                        self.textView.text = resultResponse.requestItem._id.stringValue + " – deleted" + "\n" + self.textView.text
                    }
                    else
                    {
                        // There is many object types to handle. Because there is also NSArray response (from query), we need to handle every reponses as array.
                        
                        var responseArray : [SBatchResponse] = []
                        
                        if resultResponse.body is NSArray
                        {
                            // Query with multiple responses
                            // Creates array of SBatchResponse from array of response objects – it easy handling below
                            for resultObject in resultResponse.body as! [SynergykitObject]
                            {
                                var batchResult = SBatchResponse()
                                batchResult.body = resultObject //
                                batchResult.requestItem = resultResponse.requestItem
                                responseArray.append(batchResult)
                            }
                        }
                        else
                        {
                            responseArray.append(resultResponse)
                        }
                        
                        if responseArray.count == 0
                        {
                            self.textView.text = "empty response\n" + self.textView.text
                        }
                        
                        for response in responseArray as [SBatchResponse]
                        {
                            // POST, PUT, PATCH
                            if response.body is InnerObject
                            {
                                // InnerObject
                                let body = response.body as! InnerObject
                                self.textView.text = response.requestItem._id.stringValue + " – " + body.demo.text + "\n" + self.textView.text
                            }
                            else if response.body is DemoObject
                            {
                                // DemoObject
                                let body = response.body as! DemoObject
                                self.textView.text = response.requestItem._id.stringValue + " – " + (body.text != nil ? body.text : "demo text is empty") + "\n" + self.textView.text
                            }
                            else if response.body is DemoUser
                            {
                                // DemoUser
                                let user = response.body as! DemoUser
                                self.textView.text = response.requestItem._id.stringValue + " – " + (user.name != nil ? user.name : "user hasn't name") + "\n" + self.textView.text
                            }
                            else if response.body is SPlatform
                            {
                                // SPlatform
                                let platform = response.body as! SPlatform
                                self.textView.text = response.requestItem._id.stringValue + " – " + platform.registrationId + "\n" + self.textView.text
                            }
                            else if response.body is SFile
                            {
                                // SFile
                                let file = response.body as! SFile
                                self.textView.text = response.requestItem._id.stringValue + " – " + file.path + "\n" + self.textView.text
                            }
                            else if response.body is NSDictionary
                            {
                                // NSDictionary
                                let body = response.body as! NSDictionary
                                let text : String = body["text"] != nil ? body["text"] as! String : "dict[\"text\"] is empty"
                                self.textView.text = response.requestItem._id.stringValue + " – " + text + "\n" + self.textView.text
                            }
                            else
                            {
                                self.textView.text = response.requestItem._id.stringValue + " – unsupported type\n" + self.textView.text
                            }
                        }
                    }
                }
                else
                {
                    // Request item failed
                    var append = resultResponse.requestItem._id.stringValue
                    append += " – statusCode " + resultResponse.statusCode.stringValue
                    append += resultResponse.message != nil ? ", " + resultResponse.message : ""
                    self.textView.text = append + "\n" + self.textView.text
                }
            }
            else
            {
                // There is an error
                self.textView.text = ((result.error.userInfo! as NSDictionary)[NSLocalizedDescriptionKey] as! String)
            }
        }
        
        // Creates Batch instance
        let batch = SBatch()
        
        // Prepares batch items
        let item1 = SBatchItem(id: NSNumber(int: 1), method: .POST, endpoint: "/data/" + self.COLLECTION_NAME, body: DemoObject(text:self.textField.text))
        let item2 = SBatchItem(id: NSNumber(int: 2), method: .PUT, endpoint: "/data/" + self.COLLECTION_NAME + "/" + put._id, body: put)
        let item3 = SBatchItem(id: NSNumber(int: 3), method: .PATCH, endpoint: "/data/" + self.COLLECTION_NAME + "/" + patch._id, body: patch)
        let item4 = SBatchItem(id: NSNumber(int: 4), method: .DELETE, endpoint: "/data/" + self.COLLECTION_NAME + "/" + put._id, body: nil)
        let item5 = SBatchItem(id: NSNumber(int: 5), method: .PUT, endpoint: "/data/" + self.COLLECTION_NAME + "/" + put._id, body: put) // returns 404
        let item6 = SBatchItem(id: NSNumber(int: 6), method: .POST, endpoint: "/data/" + self.COLLECTION_NAME_INNER, body: InnerObject(demo: DemoObject(text: self.textField.text), name:"name")) // inner object
        
        // Adds items to the batch like this (every item need to have wrapper)
        batch.addItem(SBatchItemWrapper(item: item1, type: DemoObject.self, handler:batchResponseHandler))
        batch.addItem(SBatchItemWrapper(item: item2, type: nil, handler:batchResponseHandler))
        batch.addItem(SBatchItemWrapper(item: item3, type: nil, handler:nil))
        
        // Or like this
        let wrapper4 = SBatchItemWrapper(item: item4, type: nil, handler: nil)
        let wrapper5 = SBatchItemWrapper(item: item5, type: DemoObject.self, handler: nil)
        let wrapper6 = SBatchItemWrapper(item: item6, type: InnerObject.self, handler: nil)
        batch.addItem(wrapper4).addItems([wrapper5, wrapper6])
        
        // You can batch SynergyObjects
        // Create and update via save
//        let object1 = DemoObject(collection: COLLECTION_NAME)
//        object1.text = "Demo string"
//        
//        let wrapper7 = object1.saveInBatch(nil)
//        batch.addItem(wrapper7)
//        
//        // Fetch
//        let object2 = DemoObject(collection: COLLECTION_NAME)
//        object2._id = existingDemoObjectId
//        
//        let wrapper8 = object2.fetchInBatch(nil)
//        batch.addItem(wrapper8)
//
//        // Destroy
//        let object3 = DemoObject(collection: COLLECTION_NAME)
//        object3._id = "dummy-id"
//        
//        let wrapper9 = object2.destroyInBatch(nil) // This destroy nothing… object with id doesn't exist. This is only example!
//        batch.addItem(wrapper9)
        
        // You can batch SynergyUsers
        // Create and update via save
//        let user1 = DemoUser()
//        user1.name = "SampleApp user"
//        
//        let wrapper10 = user1.saveInBatch(nil)
//        batch.addItem(wrapper10)
//        
//        // Fetch
//        let user2 = DemoUser()
//        user2._id = existingUserId
//        
//        let wrapper11 = user2.fetchInBatch(nil)
//        batch.addItem(wrapper11)
//
//        // Destroy
//        let user3 = DemoUser()
//        user3._id = "dummy-id"
//        
//        let wrapper12 = user3.destroyInBatch(nil) // This destroy nothing… object with id doesn't exist. This is only example!
//        batch.addItem(wrapper12)
        
        // You can batch SPlatform
        // Create or update
//        let platform1 = SPlatform(userId: existingUserId)
//        platform1.development = false
//        platform1.registrationId = "device-id"
//        
//        let wrapper13 = platform1.saveInBatch(nil)
//        batch.addItem(wrapper13)
//
//        // Fetch
//        let platform2 = SPlatform(userId: existingUserId)
//        platform2._id = existingPlatformId
//        
//        let wrapper14 = platform2.fetchInBatch(nil)
//        batch.addItem(wrapper14)
//
//        // Destroy
//        let platform3 = SPlatform(userId: existingUserId)
//        platform3._id = "dummy-id" // This destroy nothing… object with id doesn't exist. This is only example!
//        
//        let wrapper15 = platform3.destroyInBatch(nil)
//        batch.addItem(wrapper15)
        
        // You can batch SFile
        // Fetch
//        let file1 = SFile()
//        file1._id = existingFileId
//        
//        let wrapper16 = file1.fetchInBatch(nil)
//        batch.addItem(wrapper16)
//
//        // Destroy
//        let file2 = SFile()
//        file2._id = "dummy-id" // This destroy nothing… object with id doesn't exist. This is only example!
//        
//        let wrapper17 = file2.destroyInBatch(nil)
//        batch.addItem(wrapper17)

        // You can batch Query
//        batch.addItem(SQuery(object: DemoObject(collection: COLLECTION_NAME)).top(1).findInBatch(nil))
//        batch.addItem(SQuery(object: DemoObject(collection: COLLECTION_NAME)).top(5).findInBatch(nil))
//        batch.addItem(SQuery(object: SFile()).top(1).findInBatch(nil))
//        batch.addItem(SQuery(object: SFile()).top(5).findInBatch(nil))
//        batch.addItem(SQuery(object: DemoUser()).top(1).findInBatch(nil))
//        batch.addItem(SQuery(object: DemoUser()).top(5).findInBatch(nil))
        
        // And executes batch request
        batch.executeWithCompletion({
            (results : SResponseWrapper!) -> Void in
            HUD.hideUIBlockingIndicator()
            // You can handle request item response implicitly here for every object, or you can use explicit declaration of handler in every SBatchItemWrapper. Warning: Use only one way or probably you handles item two times.
            if results.succeeded()
            {
                for i in 2..<results.responses.count
                {
                    // Handles item 3–n. Item 1–2 are handled explicitly.
                    batchResponseHandler(results.responses[i] as! SResponse)
                }
            }
        })
        
        self.textField.text = ""
    }
}
