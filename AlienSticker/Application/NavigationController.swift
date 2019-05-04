import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.shadowImage = UIImage()
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        navigationBar.layer.shadowRadius = 10
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOpacity = 0.4
    }

}
