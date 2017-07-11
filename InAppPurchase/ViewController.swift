import UIKit

class ViewController: UIViewController {
	
	private lazy var inAppPurchase = InAppPurchase()
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		inAppPurchase.start(productID: "your_productID")
		
		// restore previous purchase:
		//inAppPurchase.start(productID: "your_productID", restore: true)
	}
	
}

