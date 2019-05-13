import UIKit

class StickerStore {

    public class func openWhatsappPack() {
        if let path = Bundle.main.url(forResource: "whatsapp", withExtension: "json")?.path,
           let data = try? String(contentsOfFile: path).data(using: .utf8),
           let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let result = try? JSONSerialization.data(withJSONObject: json, options: []) {

            UIPasteboard.general.setItems(
                [["net.whatsapp.third-party.sticker-pack": result]],
                options: [.localOnly: true, .expirationDate: NSDate(timeIntervalSinceNow: 60)]
            )

            UIApplication.shared.open(URL(string: "whatsapp://stickerPack")!, options: [:], completionHandler: nil)
        }
    }

    public static func getData() -> [Sticker] {
        var result: [Sticker] = []

        for index in 0...30 - 1 {
            if UIImage(named: "Sticker_\(index)") != nil {
                result.append(Sticker(image: "Sticker_\(index)", name: "comming soon ..."))
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
