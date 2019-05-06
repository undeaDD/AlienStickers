import UIKit

protocol StickerCellDelegate: class {
    func openShareSheet(_ activityViewController: UIActivityViewController)
}

class StickerCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    internal weak var delegate: StickerCellDelegate?
    internal var gesture: ForceTouchGestureRecognizer?

    func setUp(_ item: StickerStore.Sticker) {
        iconView.image = UIImage(named: item.image)

        gesture = ForceTouchGestureRecognizer(target: self, action: #selector(StickerCell.clickedSticker(_:)))
        if let gesture = gesture { self.contentView.addGestureRecognizer(gesture) }

        self.layer.cornerRadius = 3
        self.clipsToBounds = true
    }

    @objc
    func clickedSticker(_ sender: ForceTouchGestureRecognizer) {
        if sender.state == .began, let sticker = iconView.image?.withBackground(.black) {
            let activityViewController = UIActivityViewController(activityItems: [sticker], applicationActivities: nil)
            self.delegate?.openShareSheet(activityViewController)
        }
    }

}
