//
//  MessagesViewController.swift
//  iMessageExtension
//
//  Created by Dominic Drees on 13.05.19.
//  Copyright © 2019 ATINO. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var data: [StickerStore.Sticker] = StickerStore.getData()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension MessagesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

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
        cell.setUp(item)

        return cell
    }

}

public class StickerCell: UICollectionViewCell {
    @IBOutlet weak var stickerView: MSStickerView!

    func setUp(_ item: StickerStore.Sticker) {
        if let url = UIImage(named: item.image)?.getTempPath(item.name + ".png") {
            stickerView.sticker = try? MSSticker(contentsOfFileURL: url, localizedDescription: item.name)
        }
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
    }
}

extension UIImage {

    func getTempPath(_ filepath: String) -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if let filePath = paths.first?.appendingPathComponent(filepath) {
            if FileManager.default.fileExists(atPath: filePath.path) {
                // file exists already
                return filePath
            } else {
                // save and check once more
                try? self.pngData()?.write(to: filePath, options: .atomic)
                if FileManager.default.fileExists(atPath: filePath.path) {
                    return filePath
                }
            }
        }

        // cant save Image !? (no space on device left maybe)
        return nil
    }

}
