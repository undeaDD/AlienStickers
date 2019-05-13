import UIKit

class AppStore {

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

    public static func getData() -> [App] {
        return [
            App("iMessage", "Automatisch aktiviert", "sms://", "000000000", .iMessage),
            App("Whatsapp", "Version: 1.0.1", "whatsapp://stickerPack", "310633997", .enabled),
            App("Telegram", "Version: 1.0.0", "tg://addstickers?set=AlienStickerTest", "686449807", .enabled),
            App("Facebook", "In Planung", "fb://", "284882215", .disabled),
            App("Skype", "In Planung", "skype://", "304878510", .disabled),
            App("Slack", "In Planung", "slack://", "618783545", .disabled),
            App("WeChat", "In Planung", "weixin://", "414478124", .disabled)
        ]
    }

    enum AppState {
        case enabled
        case disabled
        case enabledButNotInstalled
        case iMessage
    }

    struct App {
        var title: String
        var description: String
        var url: String
        var storeId: String
        var state: AppState

        init(_ title: String, _ description: String, _ url: String, _ storeId: String, _ state: AppState) {
            self.title = title
            self.description = description
            self.url = url
            self.state = state
            self.storeId = storeId

            // Sticker Pack enabled but App not installed
            if state == .enabled, let urlscheme = URL(string: url), !UIApplication.shared.canOpenURL(urlscheme) {
                self.state = .enabledButNotInstalled
                self.description = "App nicht installiert"
            }
        }
    }

}
