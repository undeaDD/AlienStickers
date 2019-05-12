import UIKit

class PagingViewController: UIPageViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self

        for index in 0...15 {
            if let page = storyboard?.instantiateViewController(withIdentifier: "page\(index)") {
                pages.append(page)
            } else {
                break
            }
        }

        setViewControllers([pages[0]], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }

}

extension PagingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let previous = pages.firstIndex(of: viewController), previous > 0 {
            pageControl.currentPage -= 1
            return pages[previous - 1]
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let next = pages.firstIndex(of: viewController), next < pages.count - 1 {
            pageControl.currentPage += 1
            return pages[next + 1]
        } else {
            return nil
        }
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
