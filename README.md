In-App-Purchase
=============================
A simple implementation of In-App Purchase:

##### Declare Instance:
```swift
private lazy var inAppPurchase = InAppPurchase()
```
##### Place this where purchase is made:
```swift
inAppPurchase.start(productID: "your_productID")
```
##### Restore previous purchase:
```swift
inAppPurchase.start(productID: "your_productID", restore: true)
```
Implement InAppPurchase.swift, and that it!

### Requirements:
iOS 9.0 - Swift 3.1
