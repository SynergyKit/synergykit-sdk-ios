# SynergyKit iOS SDK
<p align="left" style="margin-bottom:0;" >
<img src="https://synergykit.blob.core.windows.net/synergykit/synergykitlogo.png" alt="Synergykit" title="Synergykit" width="224px">
</p>
[![Version](https://img.shields.io/cocoapods/v/SynergyKit-SDK.svg?style=flat)](http://cocoadocs.org/docsets/SynergyKit-SDK) [![License](https://img.shields.io/cocoapods/l/SynergyKit-SDK.svg?style=flat)](http://cocoadocs.org/docsets/SynergyKit-SDK) [![Platform](https://img.shields.io/cocoapods/p/SynergyKit-SDK.svg?style=flat)](http://cocoadocs.org/docsets/SynergyKit-SDK)


Letsgood.com runs Backend as a Service SynergyKit for **fast and simple mobile/web/desktop applications development**. SynergyKit allows enterpreneurs implement an idea to project fast and at low cost like Lean Startup.

We know how hard can be to work with untried API, so we prepared SDKs for mostly used platforms.

**Another SDKs**

- [Android SDK](https://github.com/SynergyKit/synergykit-sdk-android)
- [Node.js SDK](https://github.com/SynergyKit/synergykit-sdk-nodejs)
- [JavaScript SDK](https://github.com/SynergyKit/synergykit-sdk-javascript)

**Table of content**

[TOC]


## Sample Application
Almost all possibilities of SynergyKit are presented in Sample Application that was developed next to SDK as introduction of how it works.

### Sample App Installation 

 1. Clone or download the repository.
`git clone https://github.com/SynergyKit/synergykit-sdk-ios`

 2. Go to SampleApp folder in Terminal.

 3. Install pods (**CocoaPods required**).
`pod install`

 4. Open .xcworkspace file.
`open sampleapp.xcworkspace`

## SDK Installation

**SynergyKit-SDK** is available through [CocoaPods](http://cocoapods.org/pods/SynergyKit-SDK). To install it, simply add the following line to your Podfile:

`pod 'SynergyKit-SDK'`

## Architecture 

### Building a model
Building of data model is one of the most important activity in application development.

If you want to use SynergyKit SDK for development, you need to start with subclassing of `SynergykitObject` in data model. `SynergykitObject` contains *must have* properties for communication with SynergyKit - _id, __v,  createdAt and updatedAt. It also conforms to `SynergykitProtocol`,  `SBatchableProtocol` and `SCacheableProtocol` that simplify cooperation with SynergyKit.

`SynergykitObject` serialization and deserialization is based on [JSONModel](http://www.jsonmodel.com). Marin Todorov - author of JSONModel - presents nice examples of magic modelling framework on [github framework page here](https://github.com/icanzilb/JSONModel/#examples).

**Be afraid of writing model in Swift. Swift is not fully supported with JSONModel.**
#### Examples

<table>
<tbody>
<tr>
<td valign="top">
<pre>{
  "author": "Mr. Synergykit",
  "name": "Building model,
  "price": 9.5
}
</pre>
</td>
<td>
<pre>@interface BookModel : SynergykitObject
@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float price;
@end

@implementation BookModel
@end
</pre>
</td>
</tr>
</tbody>
</table>

If your object has property that isn't synchronized with server, just say that conforms to protocol `Optional` or `Ignore`. These protocols are **important for deserialization** because JSON string must contain all properties *without* these protocols. [More information about JSONModel protocols](https://github.com/icanzilb/JSONModel/blob/master/README.md#optional-properties-ie-can-be-missing-or-null).

<table>
<tbody>
<tr>
<td valign="top">
<pre>{
  "author": "Mr. Synergykit",
  "name": "Building model,
  "price": 9.5
}
</pre>
</td>
<td>
<pre>@interface BookModel : SynergykitObject
@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float price;
@property (strong, nonatomic) NSString<b>&lt;Optional&gt;</b>* category;
@property (strong, nonatomic) NSNumber<b>&lt;Ignore&gt;* </b>order;
@end

@implementation BookModel
@end
</pre>
</td>
</tr>
</tbody>
</table>

## SynergyKit Initialization
If installation process have been done, it's time for basic setup. There are required options as tenant and key and one optional - enable debugging.

Tenant and key are situated in **Settings > Application keys > Tenant** and **Settings > Application keys > Value** in Synergykit web application.

```objective-c
[Synergykit setTenant:@"tenant" key:@"key"];
[Synergykit enableDebugging:YES];
```
```swift
Synergykit.setTenant("tenant", key: "key")
Synergykit.enableDebugging(true)
```

## Responses handling
There are many options that you can receive at the end of API communication. SDK wraps these API responses in `SResponse` or `SResponseWrapper` according to request type.

Basic requests with only one object in return response as `SResponse` object, which could be handled this way.
```objective-c
^(SResponse *result) {
    if ([result succeeded])
  {
      YourType *successObject = (YourType *) result;
  }
  else
  {
      NSError *errorObject = result.error
  }
}

```
```swift
{
    (result : SResponse!) -> Void in
  if result.succeeded()
  {
      let successObject = result.result as YourType
  }
  else
  {
      let errorObject = result.error
  }
}
```
Complex requests with more than one object in return response as `SResponseWrapper` object.
```objective-c
^(SResponseWrapper *results) {
  if ([results succeeded])
  {
      for (YourType *response in results.results)
      {
        // Handle response
      }
  }
  else
  {
      for (NSError *response in results.results)
      {
          // Handle error
      }
  }
}
```
```swift
{
    (results : SResponseWrapper!) -> Void in
  if results.succeeded()
  {
      for response in results.results() as [YourType]
      {
        // Handle response
      }
  }
  else
  {
      for error in results.errors()
      {
          // Handle error
      }
  }
}
```


## Documents
Documents are data saved in collections. Collections are basically tables in database where you can store your data. By sending requests to the documents endpoint, you can list, create, update or delete documents.

### Create new document

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|collection |NSString| Location of document | **required**
| * | ? | Optional parameters | optional

```objective-c
SynergykitObject *data = [[SynergykitObject alloc] initWithCollection:@"target-collection"];

[data save:^(SResponse *result) {
   // Handle result
}];
```
```swift
let data = SynergykitObject(collection: "target-collection")

data.save {
    (result : SResponse!) -> Void in
    // Handle result
}
```
### Retrieve an existing document by ID

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|collection |NSString| Location of document | **required**
|_id |NSString| API identificator | **required**

```objective-c
SynergykitObject *data = [[SynergykitObject alloc] initWithCollection:@"target-collection" _id:@"data-id"];

[data fetch:^(SResponse *result) {
    // Handle result
}];
```
```swift
let data = SynergykitObject(collection: "target-collection", _id: "data-id")

data.fetch {
    (result : SResponse!) -> Void in
    // Handle result
}
```
### Update document
Save method executes `PUT` request if `_id` is set.

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|collection |NSString| Location of document | **required**
|_id |NSString| API identificator | **required**
| * | ? | Optional parameters | optional

```objective-c
SynergykitObject *data = [[SynergykitObject alloc] initWithCollection:@"target-collection" _id:@"data-id"];

[data save:^(SResponse *result) {
   // Handle result
}];
```
```swift
let data = SynergykitObject(collection: "target-collection", _id: "data-id")

data.save {
    (result : SResponse!) -> Void in
    // Handle result
}
```
### Delete document

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|collection |NSString| Location of document | **required**
|_id |NSString| API identificator | **required**

```objective-c
SynergykitObject *data = [[SynergykitObject alloc] initWithCollection:@"target-collection" _id:@"data-id"];

[data destroy:^(SResponse *result) {
   // Handle result
}];
```
```swift
let data = SynergykitObject(collection: "target-collection", _id: "data-id")

data.destroy {
    (result : SResponse!) -> Void in
    // Handle result
}
```

## Real-time data observerving
SDK supports real time communication through sockets. You can observe these types of changes.

- POST as `SMethodTypePOST`
- PUT as `SMethodTypePUT`
- PATCH as `SMethodTypePATCH`
- DELETE as `SMethodTypeDELETE`

`SObserver` can listen changes in whole collection or in a filtered area. 
### Checking connection state
Real-time connection state could be handled in delegate method `observingConnectionDidChangeState`.
```objective-c
[SObserver connectionDelegate:self];
```
```swift
SObserver.connectionDelegate(self)
```
### Start observing whole collection

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|object |SynergykitObject| Determines location and return type | **required**
|event |SMethodType | Listen changes on event| **required**

```objective-c
SynergykitObject *object = [[SynergykitObject alloc] initWithCollection:@"target-collection"];

SObserver *observer = [[SObserver alloc] initWithObject:object event:SMethodTypePOST];

[observer startObservingWithObjectHandler:^(id result) {
    // Handle received object
} stateHandler:^(SObserverState state, NSArray *errors) {
    // Handle changed state
}];
```
```swift
let object = SynergykitObject(collection: "target-collection")

let observer = SObserver(object: object, event: SMethodType.POST)

observer.startObservingWithObjectHandler({
    (result : AnyObject!) -> Void in
    // Handle received object
}, stateHandler: {
    (state : SObserverState, args : [AnyObject]!) -> Void in
    // Handle changed state
})
```
### Start observing collection with filter

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|object |SynergykitObject| Determines location and return type | **required**
|query |SQuery  | Sets observerving condition | **required**
|event |SMethodType | Event to be listened| **required**

```objective-c
SynergykitObject *object = [[SynergykitObject alloc] initWithCollection:@"target-collection"];

SQuery *query = [[SQuery alloc] initWithObject:object];
[query filterField:@"player" relationOperator:@"==" value:@"knight"];

SObserver *observer = [[SObserver alloc] initWithObject:query queryName:@"knight" event:SMethodTypePOST];

[observer startObservingWithObjectHandler:^(id result) {
    // Handle received object
} stateHandler:^(SObserverState state, NSArray *errors) {
    // Handle changed state
}];
```
```swift
let object = SynergykitObject(collection: "target-collection")

let query = SQuery(object: object)
query.filterField("player", relationOperator: "==", value: "knight")

let observer = SObserver(object: query, queryName: "knight", event: SMethodType.POST)

observer.startObservingWithObjectHandler({
    (result : AnyObject!) -> Void in
    // Handle received object
}, stateHandler: {
    (state : SObserverState, args : [AnyObject]!) -> Void in
    // Handle changed state
})
```
### Stop observing
```objective-c
[observer stopObserving];
```
```swift
observer.stopObserving()
```
Or if you have no reference on instance you can stop all observers by calling one method.
```objective-c
[SObserver stopAllObservers];
```
```swift
SObserver.stopAllObservers()
```
### Speak communication
Communication without data storage from device to device.

#### Send speak

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
| speakName | NSString | Name of the speak | **required**
| object | SynergykitObject | Object that will be transmitted | **required**

```objective-c
SObserver *observer = [[SObserver alloc] initWithSpeakName:@"typing"];

SynergykitUser *user = [SynergykitUser new];
user.email = @"development@synergykit.com";

[observer speakWithObject:user];
```
```swift
let observer = SObserver(speakName: "typing")

let user = SynergykitUser()
user.email = "development@synergykit.com"

observer.speakWithObject(user)
```
#### Receive speak

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|speakName |NSString|Name of the speak| **required**

```objective-c
SObserver *observer = [[SObserver alloc] initWithSpeakName:@"typing"];

[observer startObservingWithObjectHandler:^(id result) {
    // Handle received object
} stateHandler:^(SObserverState state, NSArray *errors) {
    // Handle changed state
}];
```
```swift
let observer = SObserver(speakName: "typing")

observer.startObservingWithObjectHandler({
    (result : AnyObject!) -> Void in
    // Handle received object
}, stateHandler: {
    (state : SObserverState, args : [AnyObject]!) -> Void in
    // Handle changed state
})
```

## Queries
You can retrieve multiple objects at once by sending a request with query. If query has no conditions API returns simply lists of all objects in collection.

For more complex filtering and sorting SynergyKit accepts OData standard. These queries can be used with data, users and files.

### Available conditions
Query string is builded according to [OData Protocol](http://odata.org) and is appended to the end of the url.

The OData Protocol specification defines how to standardize a typed, resource-oriented CRUD interface for manipulating data sources by providing collections of entries which must have required elements.

#### filter
Equivalent to if (field == "value" && secondField >= 33 || thirdField < 132000).
```objective-c
[query filterField:@"field" relationOperator:@"==" value:@"value"];
[query filterAnd];
[query filterField:@"secondField" relationOperator:@">=" value:[NSNumber numberWithInt:33]];
[query filterOr];
[query filterField:@"thirdField" relationOperator:@"<" value:[NSNumber numberWithInt:132000]];
```
```swift
query.filterField("field", relationOperator: "==", value: "value")
query.filterAnd()
query.filterField("secondField", relationOperator: ">=", value: NSNumber(int: 33))
query.filterOr()
query.filterField("thirdField", relationOperator: "<", value: NSNumber(int: 132000))
```

Available relation operators

- `==` or `eq`
- `!=` or `ne`
- `>=` or `ge`
- `<=` or `le`
- `>` or `gt`
- `<` or `lt`

#### startswith
```objective-c
[query startsWith:@"a" field:@"name"];
```
```swift
query.startsWith("a", field:"name")
```
#### endswith
```objective-c
[query endsWith:@"z" field:@"name"];
```
```swift
query.endsWith("z", field:"name")
```
#### substringof
```objective-c
[query substringOf:@"bc" field:@"name"];
```
```swift
query.substringOf("bc", field:"name")
```
#### in
```objective-c
[query filterIn:@"name" values:@"Lucas,Thomas"];
```
```swift
query.filterIn("name", values:"Lucas,Thomas")
```
#### nin
```objective-c
[query filterNin:@"name" values:@"John,Mark"];
```
```swift
query.filterNin("name", values:"John,Mark")
```
#### select
```objective-c
[query select:@"firstName,lastName"];
```
```swift
query.select("firstName,lastName")
```
#### top
```objective-c
[query top:5];
```
```swift
query.top(5)
```
#### orderby
```objective-c
[query orderBy:"name" direction:OrderByDirectionAsc];
```
```swift
query.orderBy("name", direction:.Asc)
```
#### inlinecount
```objective-c
[query inlineCount:YES];
```
```swift
query.inlineCount(true)
```
#### skip
```objective-c
[query skip:32];
```
```swift
query.skip(32)
```

### Querying objects
If query is prepared, you just call find method.
```objective-c
[query find:^(SResponseWrapper *result) {
    // Handle result
}]
```
```swift
query.find {
    (result : SResponseWrapper!) -> Void in
    // Handle result
}
```

### List all users

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|object |SynergykitUser| Determines location and return type| **required**

`SQuery` with `SynergykitUser` object without conditions.
```objective-c
SynergykitUser *user = [SynergykitUser new];

SQuery *query = [[SQuery alloc] initWithObject:user];

[query find:^(SResponseWrapper *result) {
    // Handle received objects
}];
```
```swift
let user = SynergykitUser()

let query = SQuery(object: user)

query.find {
  (result : SResponseWrapper!) -> Void in
    // Handle received objects
}
```
### List all documents

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|object |SynergykitObject|Determines location and return type| **required**

`SQuery` with `SynergykitObject` object without conditions.
```objective-c
SynergykitObject *data = [[SynergykitObject alloc] initWithCollection:@"target-collection"];

SQuery *query = [[SQuery alloc] initWithObject:data];

[query find:^(SResponseWrapper *result) {
    // Handle received objects
}];
```
```swift
let data = SynergykitObject(collection: "target-collection")

let query = SQuery(object: data)

query.find {
  (result : SResponseWrapper!) -> Void in
    // Handle received objects
}
```
### List all files

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|object |SFile| Determines location and return type | **required**

`SQuery` with `SFile` object without conditions.
```objective-c
SFile *file = [SFile new];

SQuery *query = [[SQuery alloc] initWithObject:file];

[query find:^(SResponseWrapper *result) {
    // Handle received objects
}];
```
```swift
let data = SFile()

let query = SQuery(object: file)

query.find {
  (result : SResponseWrapper!) -> Void in
    // Handle received objects
}
```

## Users
Users are alfa and omega of every application. In SynergyKit you can easily work with your users by methods listed below.
### Create a new user 

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
| * | ? | Optional parameters | optional

```objective-c
SynergykitUser *user = [SynergykitUser new];

[user save:^(SResponse *result) {
    // Handle result
}];
```
```swift
let user = SynergykitUser()

user.save {
  (result : SResponse!) -> Void in
  // Handle result
}
```
### Retrieve an existing user by ID

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**

```objective-c
SynergykitUser *user = [[SynergykitUser alloc] initWithId:@"object-id"];

[user fetch:^(SResponse *result) {
    // Handle result
}];
```
```swift
let user = SynergykitUser(id: "object-id")

user.fetch {
  (result : SResponse!) -> Void in
  // Handle result
}
```
### Update user
Save method executes `PUT` request if `_id` is set. 

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**
| * | ? | Optional parameters | optional

```objective-c
SynergykitUser *user = [[SynergykitUser alloc] initWithId:@"object-id"];

[user save:^(SResponse *result) {
    // Handle result
}];
```
```swift
let user = SynergykitUser(id: "object-id")

user.save {
  (result : SResponse!) -> Void in
  // Handle result
}
```
### Delete user

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**

```objective-c
SynergykitUser *user = [[SynergykitUser alloc] initWithId:@"object-id"];

[user destroy:^(SResponse *result) {
    // Handle result
}];
```
```swift
let user = SynergykitUser(id: "object-id")

user.destroy {
  (result : SResponse!) -> Void in
  // Handle result
}
```

### Add role

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**
|role |NSString| | **required**

```objective-c
SynergykitUser *user = [[SynergykitUser alloc] initWithId:@"object-id"];

[user addRole:@"master" handler:^(SResponse *result) {
    // Handle result
}];
```
```swift
let user = SynergykitUser(id: "object-id")

user.addRole("master", handler: {
  (result : SResponse!) -> Void in
  // Handle result
})
```
### Remove role

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**
|role |NSString| |**required**|

```objective-c
SynergykitUser *user = [[SynergykitUser alloc] initWithId:@"object-id"];

[user removeRole:@"master" handler:^(SResponse *result) {
    // Handle result
}];
```
```swift
let user = SynergykitUser(id: "object-id")

user.removeRole("master", handler: {
  (result : SResponse!) -> Void in
  // Handle result
})
```

### Add platform to user
Platforms are useful for pairing individual mobile devices or web applications to the user via registration ID. After assignment platform to the user you will be able to send push notifications to the device or application.

**Before you start working** with platforms of user is needed to login first. After successful login SDK receives sessionToken for authentication of user. Token is held by the SDK and is automatically inserted into the Headers.

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|development |NSNumber| Use development certificate for APNS | optional
|registrationId |NSString|Device id| **required**

```objective-c
SPlatform *platform = [SPlatform new];
platform.registrationId = @"device-token";
platform.development = [NSNumber numberWithBool:YES];

[platform save:^(SResponse *result) {
    // Handle result
}];
```
```swift
let platform = SPlatform()
platform.registrationId = "device-token"
platform.development = NSNumber(bool: true)

platform.save {
  (result : SResponse!) -> Void in
  // Handle result
}
```

### Retrive platform 

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
| _id |NSString| API identificator | **required**

```objective-c
SPlatform *platform = [[SPlatform alloc] initWithId:@"platform-id"];

[platform fetch:^(SResponse *result) {
    // Handle result
}];
```
```swift
let platform = SPlatform(id: "platform-id")

platform.fetch {
  (result : SResponse!) -> Void in
  // Handle result
}
```

### Update platform
Platforms contain of a few parameters but only two are updatable. Save method executes `PUT` request if `_id` is set, it could change `development` and `registrationId`. 

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**
| registrationId  | NSString  | Device id | optional  |
| development | NSString  | Use development certificate for APNS  | optional  |

```objective-c
SPlatform *platform = [[SPlatform alloc] initWithId:@"platform-id"];
platform.registrationId = @"new-device-token";
platform.development = [NSNumber numberWithBool:NO];

[platform save:^(SResponse *result) {
    // Handle result
}];
```
```swift
let platform = SPlatform(id: "platform-id")
platform.registrationId = "new-device-token"
platform.development = NSNumber(bool: false)

platform.save {
  (result : SResponse!) -> Void in
  // Handle result
}
```
### Delete platform

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**

```objective-c
SPlatform *platform = [[SPlatform alloc] initWithId:@"platform-id"];

[platform destroy:^(SResponse *result) {
    // Handle result
}];
```
```swift
let platform = SPlatform(id: "platform-id")

platform.destroy {
  (result : SResponse!) -> Void in
  // Handle result
}
```

### Activating user
By default, user is not activated. This mean, that you can use this state to validate user e-mail address by sending him activation link.

To activate user, send an email with this activation link /v2/users/activation/[ACTIVATION_HASH]. You can provide parameter callback with url address where you want to redirect user after activation.

Or **if you know that e-mai address is valid** you can activate user with SDK.

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**

```objective-c
SynergykitUser *user = [[SynergykitUser alloc] initWithId:@"object-id"];

[user activate:^(SResponse *result) {
    // Handle result
}];
```
```swift
let user = SynergykitUser(id: "object-id")

user.activate {
  (result : SResponse!) -> Void in
  // Handle result
}
```
### Login user
If user was registrated via normal way, which means by email and password, you can authenticate him with login method.

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|email |NSString| User e-mail | **required**
|password | NSString | User password | **required**

```objective-c
SynergykitUser *user = [SynergykitUser new];
user.email = @"dummy@synergykit.com";
user.password = @"my-password";

[user login:^(SResponse *result) {
    // Handle result
}];
```
```swift
let user = SynergykitUser()
user.email = "dummy@synergykit.com";
user.password = "my-password";

user.login {
  (result : SResponse!) -> Void in
  // Handle result
}
```

## Communication
In SynergyKit you can communicate with your users by different ways. There are listed some methods below this section.

One way is sending push notifications into user devices. This action need to have filled your API key for Android devices in Settings, section Android. For push notifications into iOS devices you need to fill your password and certificates into Apple section in Settings.

Another way is sending emails to your users. For this you need to create email templates in administration under Mailing section.

### Send notification

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|recipients | NSArray| List of recipient | **required**
|alert | NSString | Alert message of notification | optional
|badge | NSNumber | Badge to be shown on app icon | optional
|payload | NSString | Notification payload | optional
|sound | NSString | Soud to be played on notification income | optional

```objective-c
SynergykitUser *user = [[SynergykitUser alloc] initWithId:@"user-id"];

SNotification *notification = [[SNotification alloc] initWithRecipient:user];
notification.alert = @"Hello Lucas";

[notification send:^(SResponse *result) {
    // Handle result
}];
```
```swift
let user = SynergykitUser(id: "user-id")

let notification = SNotification(recipient: user)
notification.alert = "Hello Lucas"

notification.send {
  (result : SResponse!) -> Void in
  // Handle result
}
```
### Send e-mail

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|from | NSString | The sender of e-mail | optional
|to |NSString| Recipient of e-mail | **required**
|subject |NSString| Subject of e-mail | **required**
|templateName |NSString| Name of template | **required**
|args | NSArray | Mailing template arguments | optional

```objective-c
SynergykitUser *user = [SynergykitUser new];
user.email = @"dummy@synergykit.com";

SEmail *email = [SEmail new];
email.to = user;
email.subject = @"Email Example";
email.templateName = @"email-example";
email.args = @{@"name": @"Lucas"}; // according template

[email send:^(SResponse *result) {
    // Handle result
}];
```
```swift
let user = SynergykitUser()
user.email = "dummy@synergykit.com"

let email = SEmail()
email.to = user
email.subject = "Email Example"
email.templateName = "email-example"
email.args = ["name": "Lucas"] // according template

email.send {
  (result : SResponse!) -> Void in
  // Handle result
}
```
**Shorter form**
```swift
let user = SynergykitUser()
user.email = "dummy@synergykit.com"

SEmail().to(user).subject("Email Example").templateName("email-example").args(["name": "Lucas"]).send {
  (result : SResponse!) -> Void in
  // Handle result
}
```

E-mail template should looks like this example.
```
<p>Hello %name%,</p>
<br>
<p>this e-mail was send from Synergykit Sample Application.</p>
<br>
<p>Synergykit Team</p>
```

## Files
### Upload file
SynergyKit SDK supports upload with many file types, there is example of image upload. If file is successfully uploaded `SFile` representing just created file object is returned. `SFile` contains path to file from where is file accessible.

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**
| data  | NSData  | Data representing file  | **required**  |

```objective-c
SFile *file = [SFile new];

UIImage *imageToUpload = [UIImage imageNamed:@"synergykit-logo"];
NSData *imageData = UIImageJPEGRepresentation(imageToUpload, 1.0);

[file uploadJPEGImage:imageData handler:^(SResponse *result) {
    // Handle result
}];
```
```swift
let file = SFile()

let imageToUpload = UIImage(named:"synergykit-logo")
let imageData = UIImageJPEGRepresentation(imageToUpload, 1.0)

file.uploadJPEGImage(imageData handler: {
  (result : SResponse!) -> Void in
  // Handle result
})
```
### Retrieve file by ID

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**

```objective-c
[[SFile alloc] initWithId:@"file-id"] fetch:^(SResponse *result) {
    // Handle result
}];
```
```swift
SFile(id: "file-id").fetch {
    (result : SResponse!) -> Void in
    // Handle result
}
```
### Delete file

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
|_id |NSString| API identificator | **required**

```objective-c
[[SFile alloc] initWithId:@"file-id"] destroy:^(SResponse *result) {
    // Handle result
}];
```
```swift
SFile(id: "file-id").destroy {
    (result : SResponse!) -> Void in
    // Handle result
}
```

## Cloud Code
Our vision is to let developers build any app without dealing with servers. For complex apps, sometimes you just need a bit of logic that isn't running on a mobile device. Cloud Code makes this possible.

Cloud Code runs in the Node.js jailed sandbox and uses strict JavaScript language with some prepared modules and variables, which you can use for your development.
mac

### Run cloud code

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
| name  | NSString  | Function name | **required**  |
| args  | NSArray | Parameters to pass into function  | optional  |
| resultType  | Class | Type of returned data | optional  |

```objective-c
SCloudCode *cloudCode = [[SCloudCode alloc] initWithName:@"example" args:@{@"name": @"Lucas"} resultType:nil];

[cloudCode invoke:^(SResponse *result) {
    // Handle result
}];
```
```swift
let cloudCode = SCloudCode(name: "example", args: ["name": "Lucas"], resultType: nil)

cloudCode.invoke {
    (result : SResponse!) -> Void in
    // Handle result
}
```

Example cloud code function should looks like this.
```
callback("Hello " + parameters.name + "!")
```
## Batch request
We know that internet connection is sometimes unstable and we know it's not really good for synchronization algorithm where dozens of requests need to be executed without mistake. Batch request minimizes risk with connection failure - it's all in one or nothing, not first five request, then two failed (walk under the bridge) and at the end three successful.

### SBatchItem
You can batch every request you can imagine with `SBatchItem` object. At first create batch item that says where and how to do it.

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
| id  | NSNumber  | Developer identificator of request  | **required**  |
| method  | SMethodType | REST method | **required**  |
| endpoint  | NSString  | REST API endpoint | **required**  |
| body  | Child of SynergykitObject | POST request body | optional  |

```objective-c
SBatchItem *item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:1] method:SMethodTypeGET endpoint:@"/data/target-collection" body:nil];
```
```swift
let batchItem = SBatchItem(id: NSNumber(int: 1), method: .GET, endpoint: "/data/target-collection", body: nil)
```
### SBatchItemWrapper
Every batch item needs to be wrapped in `SBatchItemWrapper` where you can say what is expected in callback. If no type is set, request returns result as `NSDictionary`. Wrapper offers you to handle request response explicitly with handler. If handler is not set nothing happens, every request is handled implicitly in batch execution callback.

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
| item  | SBatchItem  | Batch item  | **required**  |
| handler | NSString  | Explicit handler for request  | optional  |
| type  | Class | Return type | optional  |

```objective-c
SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type: DemoObject.class handler:nil];
```
```swift
let wrapper = SBatchItemWrapper(item, type: DemoObject.self, handler:nil)
```
### SBatch
Execution of items is in `SBatch` object. Batch executes every request in the order in which they were added.

| Parameter | Type | Notes | |
|:-|:-|:-|:-:|
| item  | SBatchItemWrapper | Batch item wrapper  | **required**  |

```objective-c
SBatch *batch = [SBatch new];
[batch addItem:wrapper];

[batch executeWithCompletion:^(SResponseWrapper *result) {
   // Handle all results implicitly
}];
```
```swift
let batch = SBatch()
batch.addItem(wrapper)

batch.executeWithCompletion {
    (results : SResponseWrapper!) -> Void in
    // Handle all results implicitly
}
```

### Using batch
SDK allows batch every request that is available as a single request. If there is `SynergykitObject` method `save`, there is opposite method `saveInBatch` that creates `SBatchItemWrapper` for you. After wrapper is generated you can just add it in `SBatch`.

```objective-c
// Prepares requests
SynergykitUser *user = [[SynergykitUser alloc] initWithId:@"user-id"];
SBatchItemWrapper *userWrapper = [user fetchInBatch:^(SResponse *result) {
    // Handle result explicitly
}];

SynergykitObject *object = [[SynergykitObject alloc] initWithCollection:@"target-collection"];
SBatchItemWrapper *objectWrapper = [object saveInBatch:nil];

SQuery *query = [[SQuery alloc] initWithObject:[SFile new]];
[[query orderBy:@"size" direction:OrderByDirectionDesc] top:10];
SBatchItemWrapper *queryWrapper = [query findInBatch:nil];

SBatch *batch = [SBatch new];

// Fills batch with requests
[batch addItem:userWrapper];
[batch addItems:@[objectWrapper, queryWrapper]];

[batch executeWithCompletion:^(SResponseWrapper *result) {
   // Handle all results implicitly
}];
```
```swift
// Prepares requests
let user = SynergykitUser(id: "user-id")
let userWrapper = user .fetchInBatch {
    (result : SResponse!) -> Void in
    // Handle result explicitly
}

let object = SynergykitObject(collection: "target-collection")
let objectWrapper = object .saveInBatch(nil)

let query = SQuery(object: SFile())
query.orderBy("size", direction: .Desc).top(10)
let queryWrapper = query.findInBatch(nil)

let batch = SBatch()

// Fills batch with requets
batch.addItem(userWrapper)
batch.addItems([objectWrapper, queryWrapper])

batch.executeWithCompletion {
    (results : SResponseWrapper!) -> Void in
    // Handle all results implicitly
}
```

## Cache
SynergyKit iOS SDK implements new advanced cache policy with `NSURLRequestCachePolicy` support. If you want to start using cache in communication with API, just set cache parameter on object.

### SCacheTypeCacheElseLoad
Returns cached data if exists.
```objective-c
SCache *cache = [[SCache alloc] initWithType:SCacheTypeCacheElseLoad];

SynergykitObject *object = [[SynergykitObject alloc] initWithCollection:@"target-collection" _id:@"object-id"];
object.cache = cache;

[object fetch:^(SResponse *result) {
    // Handle result
}];
```
```swift
let cache = SKCache(type: .CacheElseLoad)

let object = SynergykitObject(collection: "target-collection", _id: "object-id")
object.cache = cache

object.fetch {
    (result : SResponse!) -> Void in
    // Handle result
}
```
### SCacheTypeLoadElseCache
Returns cached data if exists and internet connection is **not available**.
```objective-c
SCache *cache = [[SCache alloc] initWithType:SCacheTypeLoadElseCache];

SynergykitObject *object = [[SynergykitObject alloc] initWithCollection:@"target-collection" _id:@"object-id"];
object.cache = cache;

[object fetch:^(SResponse *result) {
    // Handle result
}];
```
```swift
let cache = SKCache(type: .LoadElseCache)

let object = SynergykitObject(collection: "target-collection", _id: "object-id")
object.cache = cache

object.fetch {
    (result : SResponse!) -> Void in
    // Handle result
}
```

### Expiration of cached data
`SCacheTypeCacheElseLoad` and `SCacheTypeLoadElseCache` support expiration interval. Cached data will be invalidate after expiration.
```objective-c
// One hour expiration
SCache *cache = [[SCache alloc] initWithType:SCacheTypeCacheElseLoad expiration:60*60]; 
```
```swift
// One hour expiration
let cache = SKCache(type: .CacheElseLoad, expiration: 60*60)
```


## Changelog
### Version 2.1.0 (22. 4. 2015)

- **SynergyKit v2.1 support**
- Documents
- Real-time data observing
- Queries
- Users
- Platforms
- Roles
- Communication
- Files
- CloudCode
- Batching requests
- Advanced Cache Policy


## Author

<img src="http://letsgood.com/src/img/logo-letsgood.png" alt="SynergyKIT" title="SynergyKIT" width="120px">

Letsgood.com s.r.o., Prague, Heart of Europe - part of Etnetera Group.

development@letsgood.com, http://letsgood.com/en

## License

Synergykit iOS SDK is available under the MIT license. See the LICENSE file for more info.