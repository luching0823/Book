//
//  ViewController.swift
//  Book
//
//  Created by 廖昱晴 on 2021/3/9.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        pageViewController = storyBoard.instantiateViewController(identifier: "PageViewController") as? UIPageViewController
        pageViewController?.dataSource = self
        pageViewController?.view.frame = self.view.frame //設定pageView畫面大小跟目前畫面一樣大小
        if let okPageViewController = pageViewController {
            addChild(okPageViewController) //將pageViewController加到viewController裡面
            view.addSubview(okPageViewController.view) //將pageViewController的畫面疊加在目前的畫面上
        }
        pageViewController?.didMove(toParent: self) //將pageViewController移到viewcController內
        guard let startPage = viewControllerAtIndex(index: 0) else { return }
        pageViewController?.setViewControllers([startPage], direction: .forward, animated: true, completion: nil)
    }

    func viewControllerAtIndex(index: Int) -> ContentViewController? { //給頁數後，回傳給ContentViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let contentViewController = storyBoard.instantiateViewController(identifier: "MainContentViewController") as? ContentViewController
        contentViewController?.nowPageNumber = index
        
        return contentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as? ContentViewController //目前畫面
        guard var index = vc?.nowPageNumber else { return nil } //目前畫面頁碼
        if index == 0 || index == NSNotFound {
            return nil
        } else {
            index -= 1
            return viewControllerAtIndex(index: index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as? ContentViewController
        guard var index = vc?.nowPageNumber else { return nil }
        if index == NSNotFound {
            return nil
        } else {
            index += 1
            if index >= 3 {
                return nil
            } else {
                return viewControllerAtIndex(index: index)
            }
        }
    }

}

