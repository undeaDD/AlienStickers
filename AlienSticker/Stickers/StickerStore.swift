import UIKit

class StickerStore {

    public static func getData() -> [Sticker] {
        var result: [Sticker] = []

        for index in 0...30 - 1 {
            if UIImage(named: "Sticker_\(index)") != nil {
                result.append(Sticker(image: "Sticker_\(index)", name: "Sticker_\(index).png"))
            } else {
                break
            }
        }

        return result
    }

    struct Sticker {
        var image: String
        var name: String
    }

}
