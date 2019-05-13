import UIKit

class PagingViewController: UIPageViewController {
    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self

        for index in 0...10 {
            if index == 10 { print("[Warning]: Tutorial may be exceeding the Limit of 10 Scenes") }
            if let identifiersList = storyboard?.value(forKey: "identifierToNibNameMap") as? [String: Any],
               identifiersList["page\(index)"] != nil,
               let page = storyboard?.instantiateViewController(withIdentifier: "page\(index)") {
                pages.append(page)
            } else {
                break
            }
        }

        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let lastPagingDot = self.view.subviews.last?.subviews.last {
            lastPagingDot.backgroundColor = .red
        }
    }

    @IBAction func close(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }

}

extension PagingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let previous = pages.firstIndex(of: viewController), previous > 0 {
            return pages[previous - 1]
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let next = pages.firstIndex(of: viewController), next < pages.count - 1 {
            return pages[next + 1]
        } else {
            self.dismiss(animated: true)
            return nil
        }
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count + 1
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
