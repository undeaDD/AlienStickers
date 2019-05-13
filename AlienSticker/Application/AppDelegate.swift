import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window?.backgroundColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 1)
        return true
    }

}

extension UIImage {
    func withBackground(_ color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        color.setFill()
        UIRectFill(rect)

        self.draw(at: .zero)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return image
    }
}

extension UIApplicationDelegate {

    func showTutorial() {
        if let initialView = UIStoryboard(name: "Welcome", bundle: nil).instantiateInitialViewController(),
           let presenter = self.window??.rootViewController {
            presenter.present(initialView, animated: false, completion: nil)
        }
    }

}
