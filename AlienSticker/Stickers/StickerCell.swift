import UIKit

class StickerCell: UICollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    
    func setUp(_ item: StickerStore.Sticker) {
        iconView.image = UIImage(named: item.image)
        
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
    }
    
}
