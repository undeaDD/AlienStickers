import UIKit
import StoreKit

class AppCell: UITableViewCell {
    
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
        installButton.isHidden = true
        
        if let enabled = item.isEnabled {
            installButton.isHidden = false
            installButton.setTitle(enabled ? "Hinzufügen" : "AppStore", for: .normal)
            descriptionLabel.alpha = enabled ? 1.0 : 0.5
            iconView.alpha = enabled ? 1.0 : 0.5
            self.url = enabled ? item.url : item.storeId
        } else if item.title == "iMessage" {
            descriptionLabel.alpha = 1.0
            iconView.alpha = 1.0
        } else {
            descriptionLabel.alpha = 0.5
            iconView.alpha = 0.5
        }
    }
    
    @IBAction func installPack(_ sender: UIButton) {
        if self.url == "whatsapp://" {
            if let stickerPack = try? StickerPack(identifier: "de.atino.AlienSticker", name: "AlienSticker", publisher: "DeltaSiege.eu", trayImageFileName: "pack.png", publisherWebsite: "https://www.deltasiege.eu", privacyPolicyWebsite: nil, licenseAgreementWebsite: nil) {
                
                for (data, emojis) in StickerStore.getWhatsappPack() {
                    do {
                        try stickerPack.addSticker(imageData: UIImage(named: data)!.pngData()!, type: .png, emojis: emojis)
                    } catch let error { print(error.localizedDescription) }
                }
                
                stickerPack.sendToWhatsApp { _ in }
            }
        } else if let url = URL(string: self.url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            let vc = SKStoreProductViewController()
            vc.delegate = self
            vc.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: self.url], completionBlock: nil)
            if let tabBar = UIApplication.shared.delegate?.window??.rootViewController as? TabBarController {
                tabBar.present(vc, animated: true)
            }
        }
    }
    
}

extension AppCell: SKStoreProductViewControllerDelegate {
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true)
    }
    
}
