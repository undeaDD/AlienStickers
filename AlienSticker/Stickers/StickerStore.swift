import UIKit

class StickerStore {
    
    public static var mode: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "StickerMode")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "StickerMode")
        }
    }
    
    public static func getWhatsappPack() -> [(String, [String])] {
        var result: [(String, [String])] = []
        
        result.append(("Sticker_0", ["😀", "😃", "😄"]))
        result.append(("Sticker_1", ["🤣", "☺️", "😊"]))
        result.append(("Sticker_2", ["😌", "😍", "🥰"]))
        result.append(("Sticker_3", ["😋", "😛", "😝"]))
        result.append(("Sticker_4", ["🤓", "😎", "🤩"]))
        result.append(("Sticker_5", ["🧐", "🤪", "😇"]))
        
        return result
    }
    
    public static func getData() -> [Sticker] {
        var result: [Sticker] = []
        
        for index in 0...100 {
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
