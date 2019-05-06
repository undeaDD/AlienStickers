import UIKit

class StickerStore {
    
    static let emojis: [String] = ["😀😊", "😃😇", "😄🙂", "😁🙃", "😆😉", "😅😌", "😂😍", "🤣🥰", "☺️😘", "😀😊", "😃😇", "😄🙂", "😁🙃", "😆😉", "😅😌", "😂😍", "🤣🥰", "☺️😘", "😀😊", "😃😇", "😄🙂", "😁🙃", "😆😉", "😅😌", "😂😍", "🤣🥰", "☺️😘", "😀😊", "😃😇", "😄🙂", "😁🙃", "😆😉", "😅😌", "😂😍", "🤣🥰"]
    
    public class func openWhatsappPack() {
        if let stickerPack = try? StickerPack(identifier: "de.atino.AlienSticker", name: "AlienSticker", publisher: "ATINO GmbH", trayImageFileName: "pack.png") {
            
            for index in 0...emojis.count - 1 {
                if let _ = UIImage(named: "Sticker_\(index)") {
                    do {
                        try stickerPack.addSticker("Sticker_\(index)", StickerStore.emojis[index])
                    } catch let error { print(error.localizedDescription) }
                } else {
                    break
                }
            }
            
            stickerPack.sendToWhatsApp { _ in }
        }
    }
    
    public static func getData() -> [Sticker] {
        var result: [Sticker] = []
        
        for index in 0...emojis.count - 1 {
            if let _ = UIImage(named: "Sticker_\(index)") {
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
