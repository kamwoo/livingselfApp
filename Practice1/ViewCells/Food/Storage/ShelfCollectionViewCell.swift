//
//  ShelfCollectionViewCell.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/16.
//

import Foundation
import UIKit

enum CollectionViewUpdateState<T>{
    case delete(Int)
    case insert(T, Int)
}

class ShelfCollectionViewCell: UICollectionViewCell {
    static let identifier = "ShelfCollectionViewCell"
    
    private var sampleDate = [FoodViewModel]()
    
    private let collectionView : UICollectionView = {
        let collectView = UICollectionView(frame: .zero, collectionViewLayout: ColumnFlowLayout())
        return collectView
    }()
    
    private let Insertbutton: UIButton = {
       let button = UIButton()
        button.layer.masksToBounds = true
        button.backgroundColor = .green
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        configureCollectionView()
        contentView.addSubview(Insertbutton)
        Insertbutton.addTarget(self, action: #selector(didTapInsertButton), for: .touchUpInside)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapInsertButton(){
        let sampleUpdates = [
            CollectionViewUpdateState<FoodViewModel>
                .insert(FoodViewModel(foodName: "오뎅", foodIcon: "heart"),
                        collectionView.numberOfItems(inSection: 0))
        ]
        performUpdate(sampleUpdates: sampleUpdates)
    }
    
    private func configureCollectionView(){
        contentView.addSubview(collectionView)
        collectionView.register(FoodIconCollectionViewCell.self,
                                forCellWithReuseIdentifier: FoodIconCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = CGRect(x: contentView.bounds.width/12,
                                      y: 0,
                                      width: contentView.bounds.width*5/6,
                                      height: contentView.bounds.height)
        let buttonSize = contentView.bounds.width/8
        Insertbutton.frame = CGRect(x: contentView.width/2-buttonSize/2,
                                    y: contentView.bottom-buttonSize,
                                    width: buttonSize,
                                    height: buttonSize)
        Insertbutton.layer.cornerRadius = buttonSize/2
    }
    
    func configure(){
        sampleDate.append(FoodViewModel(foodName: "파", foodIcon: "heart"))
        sampleDate.append(FoodViewModel(foodName: "김치", foodIcon: "heart"))
        sampleDate.append(FoodViewModel(foodName: "무", foodIcon: "heart"))
        sampleDate.append(FoodViewModel(foodName: "배", foodIcon: "heart"))
    }
    
    private func performUpdate(sampleUpdates: [CollectionViewUpdateState<FoodViewModel>]){
        collectionView.performBatchUpdates{
            var deletes = [Int]()
            var inserts = [(shelf:FoodViewModel, index:Int)]()
            
            sampleUpdates.forEach {
                switch $0 {
                case let .delete(index):
                    collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
                    deletes.append(index)
                case let .insert(shelf, index):
                    collectionView.insertItems(at: [IndexPath(item: index, section: 0)])
                    inserts.append((shelf,index))
                }
            }
            deletes.sorted().reversed().forEach{
                sampleDate.remove(at: $0)
            }
            inserts.sorted(by: {return $0.index <= $1.index})
                .forEach{sampleDate.insert($0.shelf, at: $0.index)}
        }completion: { _ in
            print("update")
        }
    }
}

extension ShelfCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FoodIconCollectionViewCell.identifier,
                for: indexPath) as? FoodIconCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = sampleDate[indexPath.row]
        cell.configure(viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sampleUpdates = [
            CollectionViewUpdateState<FoodViewModel>.delete(indexPath.row)
        ]
        performUpdate(sampleUpdates: sampleUpdates)
    }
    
}
