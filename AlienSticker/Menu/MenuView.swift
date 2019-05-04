import UIKit
import StoreKit
import MessageUI
import SwiftMessages

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "  Einstellungen"
        case 1:
            return "  Rechtliches"
        default:
            return "  Informationen"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as? MenuCell else {
            fatalError()
        }
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            guard let modeCell = tableView.dequeueReusableCell(withIdentifier: "modeCell") as? ModeCell else {
                fatalError()
            }
            modeCell.setUp()
            return modeCell
        case (1, 0):
            cell.setUp("book", "Impressum")
        case (1, 1):
            cell.setUp("protection", "Datenschutz")
        case (1, 2):
            cell.setUp("license", "Lizenzen")
        case (2, 0):
            cell.setUp("rate", "App Bewerten")
        case (2, 1):
            cell.setUp("feedback", "Feedback geben")
        case (2, 2):
            cell.setUp("request", "Sticker wünschen")
        default:
            fatalError()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (1, 3):
            SKStoreReviewController.requestReview()
        case (1, 4):
            guard MFMailComposeViewController.canSendMail() else {
                noMailAccount()
                return
            }

            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("[AlienSticker] Feedback")
            mail.setToRecipients(["dominic.drees@atino.de"])
            present(mail, animated: true)
        case (1, 5):
            guard MFMailComposeViewController.canSendMail() else {
                noMailAccount()
                return
            }

            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("[AlienSticker] Sticker Wunsch")
            mail.setToRecipients(["dominic.drees@atino.de"])
            present(mail, animated: true)
        case (1, let index):
            performSegue(withIdentifier: "showWebView", sender: index)
        default:
            return
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let webView = segue.destination as? WebView {
            webView.type = sender as? Int
        }
    }
    
}

extension MenuViewController: MFMailComposeViewControllerDelegate {
    
    private func noMailAccount() {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: "Fehler", body: "Kein Email Account eingerichtet")
        view.layoutMarginAdditions = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 16
        view.configureTheme(.warning)
        view.configureDropShadow()
        view.backgroundView.backgroundColor = .red
        view.button?.isHidden = true
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.preferredStatusBarStyle = .lightContent
        config.presentationContext = .window(windowLevel: .statusBar)
        
        SwiftMessages.hideAll()
        SwiftMessages.show(config: config, view: view)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
