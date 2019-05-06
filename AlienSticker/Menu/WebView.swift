import UIKit
import WebKit

class WebView: UIViewController {
    
    enum WebType: String {
        case impressum = "Impressum"
        case lizenzen = "Lizenzen"
        case datenschutz = "Datenschutz"
        
        public static func fromInt(_ integer: Int) -> WebType {
            return integer == 2 ? .lizenzen : integer == 1 ? .datenschutz : .impressum
        }
    }
    
    @IBOutlet weak var webView: WKWebView!
    var type: WebType = .impressum
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = type.rawValue
        if let url = Bundle.main.url(forResource: type.rawValue.lowercased(), withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
    }
    
}
