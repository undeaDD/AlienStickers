import UIKit
import WebKit

class WebView: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var type: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch type ?? 0 {
        case 0:
            navigationItem.title = "Impressum"
            if let url = Bundle.main.url(forResource: "impressum", withExtension: "html") {
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
        case 1:
            navigationItem.title = "Datenschutz"
            if let url = Bundle.main.url(forResource: "datenschutz", withExtension: "html") {
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
        case 2:
            navigationItem.title = "Lizenzen"
            if let url = Bundle.main.url(forResource: "lizenzen", withExtension: "html") {
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
        default:
            fatalError()
        }
    }
    
}
