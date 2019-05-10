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
        definesPresentationContext = true
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Rechtliches"
        default:
            return "Informationen"
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as? MenuCell else {
            fatalError("invalid cell dequeued")
        }

        switch (indexPath.section, indexPath.row) {
        case (0, 1):
            cell.setUp("protection", "Datenschutz")
        case (0, 2):
            cell.setUp("license", "Lizenzen")
        case (0, 3):
            cell.setUp("contact", "Kontakt")
        case (1, 0):
            cell.setUp("rate", "App Bewerten")
        case (1, 1):
            cell.setUp("feedback", "Feedback geben")
        case (1, 2):
            cell.setUp("request", "Sticker wünschen")
        case (1, 3):
            cell.setUp("tutorial", "Einführung anzeigen")
        default:
            cell.setUp("book", "Impressum")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (1, 0):
            SKStoreReviewController.requestReview()
        case (1, 1):
            guard MFMailComposeViewController.canSendMail() else { noMailAccount(); return }

            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("[AlienSticker] Feedback")
            mail.setToRecipients(["dominic.drees@atino.de"])
            present(mail, animated: true)
        case (1, 2):
            guard MFMailComposeViewController.canSendMail() else { noMailAccount(); return }

            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("[AlienSticker] Sticker Wunsch")
            mail.setToRecipients(["dominic.drees@atino.de"])
            present(mail, animated: true)
        case (1, 3):
            if let initialView = UIStoryboard(name: "Welcome", bundle: nil).instantiateInitialViewController() {
                UIApplication.shared.delegate?.window??.rootViewController?.present(initialView, animated: true, completion: nil)
            }
        case (_, let index):
            performSegue(withIdentifier: "showWebView", sender: WebView.WebType.fromInt(index))
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? WebView)?.type = (sender as? WebView.WebType) ?? .impressum
    }

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
