//
//  MovieListPageContainerViewController.swift
//  Movie_App
//
//  Created by MAC110 on 1/10/19.
//  Copyright © 2019 MAC110. All rights reserved.
//
import UIKit
import FSPagerView
import RxSwift
import RxCocoa

class MovieListPageContainerViewController: BaseViewController {
    
    
    @IBOutlet weak private var btnNowShowing   : UIButton!
    @IBOutlet weak private var btnCommingSoon  : UIButton!
    @IBOutlet weak private var vwDivider       : UIView!
    
    
    var arrViewController : [UIViewController]!
    var pageViewController : UIPageViewController!
    var viewModel : MovieListPageContainerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

//MARK: - Setup
extension MovieListPageContainerViewController{
    private func setup(){
        self.setupUI()
        self.setupBinding(viewModel: self.viewModel)
    }
    private func setupUI(){
        self.configureNavigationWithTitle(title: "")
    }
    private func setupBinding(viewModel: MovieListPageContainerViewModel){
        super.setupBindingForBaseViewModel(viewModel: viewModel)
        self.btnNowShowing.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else {return}
                self.selectViewControllerAtIndex(index: 0)
            }).disposed(by: self.disposeBag)
        self.btnCommingSoon.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else {return}
                self.selectViewControllerAtIndex(index: 1)
            }).disposed(by: self.disposeBag)
       
        
    }
}
//MARK: - Custom PageUI Method
extension MovieListPageContainerViewController{
    func selectViewControllerAtIndex(index:Int) {
        
        if viewModel.selectedIndex.value <= index {
            pageViewController.setViewControllers([arrViewController[index]], direction: .forward, animated: true, completion: nil)
            
        }
        else {
            pageViewController.setViewControllers([arrViewController[index]], direction: .reverse, animated: true, completion: nil)
        }
        self.viewModel.selectedIndex.value = index
        self.moveDeviderToIndex(index: index)
    }
    func moveDeviderToIndex(index: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else {return}
            self.btnNowShowing.isSelected = index == 0
            self.btnCommingSoon.isSelected = index == 1
            UIView.animate(withDuration: 0.3, animations: {
                let x = CGFloat(index) * (Screen.width * 0.5)
                self.vwDivider.frame.origin.x = x
            }, completion: { (animated) in
                self.vwDivider.layoutIfNeeded()
            })
        }
    }
}

//PageControllerMethod
extension MovieListPageContainerViewController :UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        pageViewController = (segue.destination as! UIPageViewController)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        self.arrViewController = viewModel.viewControllers
        
        pageViewController.setViewControllers([arrViewController.first!], direction: .forward, animated: true, completion: nil)
    }
    
    // MARK: - Page view controller methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = arrViewController.index(of: viewController)
        
        if index == arrViewController.count - 1 {//Last view controller.Can not go forward
            return nil
        }
        index = index! + 1
        return arrViewController[index!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = arrViewController.index(of: viewController)
        if index == 0 {//First view controller.Can not go backward
            return nil
        }
        
        index = index! - 1
        return arrViewController[index!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            self.moveDeviderToIndex(index: viewModel.selectedIndex.value)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        viewModel.selectedIndex.value = arrViewController.index(of: pendingViewControllers.first!)!
    }
}



