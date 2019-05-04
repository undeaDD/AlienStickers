import UIKit

class AppStore {

    public static func getData() -> [App] {
        var result: [App] = []
        
        result.append(App("iMessage", "Automatisch aktiviert", "sms://", "", nil ))
        result.append(App("Whatsapp", "Version: 1.0.0", "whatsapp://", "310633997" ))
        result.append(App("Telegram", "Version: 1.0.0", "tg://addstickers?set=AlienStickerTest", "686449807" ))
        result.append(App("Facebook", "In Planung"    , "fb://"      , "284882215" ))
        result.append(App("Skype"   , "In Planung"    , "skype://"   , "304878510", nil))
        result.append(App("Slack"   , "In Planung"    , "slack://"   , "618783545", nil))
        result.append(App("WeChat"  , "In Planung"    , "weixin://"  , "414478124", nil))
        
        return result
    }
    
    
    
    struct App {
        var title: String
        var description: String
        var url: String
        var storeId: String
        var isEnabled: Bool? = true
        
        init(_ title: String, _ description: String, _ url: String, _ storeId: String,  _ isEnabled: Bool? = true) {
            self.title = title
            self.description = description
            self.url = url
            self.isEnabled = isEnabled
            self.storeId = storeId
            
            if let enabled = isEnabled, enabled, let tempURL = URL(string: url), !UIApplication.shared.canOpenURL(tempURL) {
                self.isEnabled = false
                self.description = "App nicht installiert"
            }
        }
    }
    
}
