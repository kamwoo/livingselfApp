//
//  FoodViewController.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/05.
//

import UIKit

class FoodViewController: UIViewController, CustomSegmentedControlDelegate {
    private let StorageVC = FoodStorageViewController()
    private let RecipeVC = FoodRecipeViewController()
    
    private let topView : UIView = {
       let topView = UIView()
        topView.backgroundColor = UIColor(displayP3Red: 246/255, green: 238/255, blue: 221/255, alpha: 1)
        return topView
    }()
    
    private let scrollView : UIScrollView = {
       let view = UIScrollView()
        view.isPagingEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 246/255, green: 238/255, blue: 221/255, alpha: 1)
        view.addSubview(topView)
        configureScrollView()
        configureSegment()
        addChildView()
    }
    
    private func addChildView(){
        addChild(StorageVC)
        scrollView.addSubview(StorageVC.view)
        StorageVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        StorageVC.didMove(toParent: self)
        
        addChild(RecipeVC)
        scrollView.addSubview(RecipeVC.view)
        RecipeVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        RecipeVC.didMove(toParent: self)
    }
    
    private func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor(displayP3Red: 246/255, green: 238/255, blue: 221/255, alpha: 1)
        scrollView.contentSize = CGSize(width: view.width*2, height: scrollView.height)
    }
    
    private func configureSegment(){
        let segHeight = view.bounds.height/20
        let segment = CustomSegmentedControl(
            frame: CGRect(x: view.bounds.width/4, y: segHeight, width: view.bounds.width/2, height: segHeight),
            buttonTitles: ["Foods","Recipes"],
            startIndex: 0)
        view.addSubview(segment)
        segment.delegate = self
    }
    
    func ChangeToIndex(index: Int) {
        if index == 0 {
            scrollView.setContentOffset(.zero, animated: true)
        }else{
            scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.frame = CGRect(x: 0,
                               y: 0,
                               width: view.bounds.width,
                               height: view.bounds.height/9)
        scrollView.frame = CGRect(x: 0,
                                  y: topView.bottom,
                                  width: view.bounds.width,
                                  height: view.bounds.height-topView.height)
    }
}

extension FoodViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.x >= (view.width - 100) {
//
//        }
    }
}
