import UIKit
import WebKit

class WebView: UIViewController {

    enum WebType: String {
        case impressum = "Impressum"
        case lizenzen = "Lizenzen"
        case datenschutz = "Datenschutz"
        case contact = "Kontakt"

        public static func fromInt(_ integer: Int) -> WebType {
            switch integer {
            case 1:
                return .datenschutz
            case 2:
                return .lizenzen
            case 3:
                return .contact
            default:
                return .impressum
            }
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
