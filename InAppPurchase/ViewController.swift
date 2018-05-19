import UIKit

class ViewController: UIViewController {
	
	private lazy var inAppPurchase = InAppPurchase()
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		inAppPurchase.start(productID: "yourproductID")
		
		// restore previous purchase:
		//inAppPurchase.start(productID: "yourproductID", restore: true)
		
	}
	
}

