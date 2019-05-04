import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setUp(_ image: String, _ title: String) {
        iconView.image = UIImage(named: image)
        titleLabel.text = title
    }
        
}

class ModeCell: UITableViewCell {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBAction func selectMode(_ sender: UISegmentedControl) {
        StickerStore.mode = sender.selectedSegmentIndex == 0 ? true : false
    }
    
    func setUp() {
        segment.selectedSegmentIndex = StickerStore.mode ? 0 : 1
    }
    
}
