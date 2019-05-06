import UIKit

class AppListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var data = AppStore.getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: -23, left: 0, bottom: -12, right: 0)
        tableView.tableFooterView = UIView()
    }
    
}

extension AppListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "appCell") as? AppCell else {
            fatalError()
        }
        
        let item = data[indexPath.section]
        cell.setUp(item)
        
        return cell
    }
    
}
