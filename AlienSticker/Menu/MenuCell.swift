import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setUp(_ image: String, _ title: String) {
        iconView.image = UIImage(named: image)
        titleLabel.text = title
    }
        
}
