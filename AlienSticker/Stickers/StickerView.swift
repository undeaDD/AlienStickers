import UIKit
import SwiftMessages

class StickerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var data: [StickerStore.Sticker] = StickerStore.getData()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Show Tutorial on first App Launch
        if UserDefaults.standard.object(forKey: "firstTimeLaunch") as? Bool ?? true {
            UserDefaults.standard.set(false, forKey: "firstTimeLaunch")
            UIApplication.shared.delegate?.showTutorial()
        }
    }

}

extension StickerViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, StickerCellDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let square = collectionView.bounds.width / 3 - 16
        return CGSize(width: square, height: square)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stickerCell", for: indexPath) as? StickerCell else {
            fatalError("invalid cell dequeued")
        }

        let item = self.data[indexPath.row]
        cell.delegate = self
        cell.setUp(item)

        return cell
    }

    func openShareSheet(_ activityViewController: UIActivityViewController) {
        SwiftMessages.hideAll()
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? StickerCell,
           let sticker = cell.iconView.image?.withBackground(.black) {
            UIPasteboard.general.image = sticker

            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureContent(title: "Erfolgreich kopiert", body: "Der Sticker wurde in die Zwischenablage gelegt")
            view.layoutMarginAdditions = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            (view.backgroundView as? CornerRoundingView)?.cornerRadius = 16
            view.configureTheme(.success)
            view.configureDropShadow()
            view.button?.isHidden = true

            var config = SwiftMessages.Config()
            config.presentationStyle = .bottom
            config.preferredStatusBarStyle = .lightContent
            config.presentationContext = .window(windowLevel: .statusBar)

            SwiftMessages.hideAll()
            SwiftMessages.show(config: config, view: view)
        }
    }

}
