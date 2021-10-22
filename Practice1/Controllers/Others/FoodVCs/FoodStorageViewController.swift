//
//  FoodStorageViewController.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/16.
//

import UIKit

enum FoodSectionType {
    case shelf(viewModel: [FoodViewModel])
    case refrigerator(viewModel: [FoodViewModel])
}

class FoodStorageViewController: UIViewController {

    private var FoodSection = [FoodViewModel]()
    
    lazy private var foodCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .gray
        collectionView.backgroundColor = UIColor(displayP3Red: 246/255, green: 238/255, blue: 221/255, alpha: 1)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 246/255, green: 238/255, blue: 221/255, alpha: 1)
        configureFoodCollectionView()
    }
    
    private func configureFoodCollectionView(){
        view.addSubview(foodCollectionView)
        foodCollectionView.register(ShelfCollectionViewCell.self,
                                    forCellWithReuseIdentifier: ShelfCollectionViewCell.identifier)
        foodCollectionView.register(RefrigeratorCollectionViewCell.self,
                                    forCellWithReuseIdentifier: RefrigeratorCollectionViewCell.identifier)
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        foodCollectionView.frame = CGRect(x: 0,
                                          y: view.safeAreaInsets.top,
                                          width: view.bounds.width,
                                          height: view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
        
    }
    

}


extension FoodStorageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ShelfCollectionViewCell.identifier, for: indexPath)
            cell.backgroundColor = .gray
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RefrigeratorCollectionViewCell.identifier, for: indexPath)
            cell.backgroundColor = .gray
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height/2 - view.bounds.height/12)
    }
}

