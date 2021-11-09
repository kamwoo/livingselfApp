//
//  FoodViewController.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/05.
//

import UIKit

class FoodViewController: UIViewController {
    
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
    
    private let ToggleView = FoodToggleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 246/255, green: 238/255, blue: 221/255, alpha: 1)
        view.addSubview(topView)
        configureScrollView()
        view.addSubview(ToggleView)
        ToggleView.delegate = self
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
        let ToggleViewWidth = view.bounds.width*2/3
        let ToggleViewHeight = view.bounds.height/22
        ToggleView.frame = CGRect(x: view.bounds.width/2 - ToggleViewWidth/2,
                                  y: topView.bottom - ToggleViewHeight*4/3,
                                  width: ToggleViewWidth,
                                  height: ToggleViewHeight)
    }
}

extension FoodViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == (view.width) {
            ToggleView.update(for: .Recipe)
            FoodRecipeViewController().recipeUpdate()
        }
        else{
            ToggleView.update(for: .Storage)
        }
    }
}

extension FoodViewController: FoodToggleViewDelegate {
    func FoodToggleViewDidTapStorage(_ toggleView: FoodToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    func FoodToggleViewDidTapRecipe(_ toggleView: FoodToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
    }
    
}
