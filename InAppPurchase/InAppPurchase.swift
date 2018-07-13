import StoreKit

class InAppPurchase: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
	
	private lazy var restore = false
	
	/**
		Starts the in-app purchase process
		- parameters:
		  - productID: Product ID from iTunes connect
		  - restore: Restore previous purchase
		*/
	func start(productID: String, restore: Bool = false) {
		self.restore = restore
		SKPaymentQueue.default().add(self)
		request(productID)
	}
	
 /// Fetches product information
	private func request(_ id: String) {
		if SKPaymentQueue.canMakePayments() {
			let productID = NSSet(object: id) as! Set<String>
			let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID)
			productsRequest.delegate = self
			productsRequest.start()
			print("Fetching Products")
		} else {
			print("Restricted from accessing the App Store. Settings > General > Restrictions: enable App Store")
		}
	}
	
	/// Received response from product request (Delegate)
	func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		if (response.products.count > 0) {
			let product = response.products[0] as SKProduct
			print(product.localizedTitle)
			print(product.localizedDescription)
			print(product.price)
			restore ? SKPaymentQueue.default().restoreCompletedTransactions() : purchase(product: product)
		} else {
			print("Error: Make sure the bundle Identifier matches the app, and check the product identifier")
		}
	}
	
	/// Make the purchase
	private func purchase(product: SKProduct) {
		let payment = SKPayment(product: product)
		SKPaymentQueue.default().add(payment)
	}
	
	/// Received when the transaction array has changed. (Observer)
	func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		for transaction:AnyObject in transactions {
			if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction {
				switch trans.transactionState {
				case .purchasing:
					print("Transaction state -> Purchasing")
				case .purchased:
					print("Transaction state -> Purchased")
					SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
				case .restored:
					print("Transaction state -> Restored")
					SKPaymentQueue.default().restoreCompletedTransactions()
				case .failed:
					print("Transaction state -> Failed or Cancelled")
					SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
				default: break
				}
			}
		}
	}
	
}
