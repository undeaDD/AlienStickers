import UIKit
import StoreKit

class AppCell: UITableViewCell, SKStoreProductViewControllerDelegate {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var installButton: UIButton!
    private var url: String = "sms://"
    
    func setUp(_ item: AppStore.App) {
        iconView.image = UIImage(named: item.title)
        iconView.layer.cornerRadius = 12
        iconView.clipsToBounds = true
        
        let text = NSMutableAttributedString(string: item.title + "\n", attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .bold)])
        text.append(NSAttributedString(string: item.description, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular)]))
        descriptionLabel.attributedText = text
        
        installButton.layer.borderWidth = 1
        installButton.layer.borderColor = UIColor.white.cgColor
        installButton.layer.cornerRadius = 5
        
        switch item.state {
        case .enabled:
            installButton.isHidden = false
            installButton.setTitle("Hinzufügen", for: .normal)
            descriptionLabel.alpha = 1.0
            iconView.alpha = 1.0
            self.url = item.url
        case .enabledButNotInstalled:
            installButton.isHidden = false
            installButton.setTitle("AppStore", for: .normal)
            descriptionLabel.alpha = 0.5
            iconView.alpha = 0.5
            self.url = item.storeId
        case .disabled:
            installButton.isHidden = true
            descriptionLabel.alpha = 0.5
            iconView.alpha = 0.5
        case .iMessage:
            installButton.isHidden = true
            descriptionLabel.alpha = 1.0
            iconView.alpha = 1.0
        }
    }
    
    @IBAction func installPack(_ sender: UIButton) {
        if self.url == "whatsapp://" {
            // Whatsapp specific Code
            StickerStore.openWhatsappPack()
        } else if let url = URL(string: self.url), UIApplication.shared.canOpenURL(url) {
            // Try to open urlscheme
            UIApplication.shared.open(url)
        } else {
            // Download App from the Appstore
            let vc = SKStoreProductViewController()
            vc.delegate = self
            vc.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: self.url], completionBlock: nil)
            if let tabBar = UIApplication.shared.delegate?.window??.rootViewController as? TabBarController {
                tabBar.present(vc, animated: true)
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true)
    }

}
