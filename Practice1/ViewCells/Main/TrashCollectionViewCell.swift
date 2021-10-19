//
//  SeperateCollectionCollectionViewCell.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/11.
//

import UIKit

class TrashCollectionViewCell: UICollectionViewCell, CustomSegmentedControlDelegate {
    static let identifier = "SeperateCollectionCollectionViewCell"
    
    private let week = ["월","화","수","목","금","토","일"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemBackground
        configSegmentControl()
    }
    
    private func configSegmentControl(){
        let codeSegmented = CustomSegmentedControl(
            frame: CGRect(x: contentView.width/9,
                          y: contentView.height/11,
                          width: contentView.width*7/9,
                          height: contentView.height/10),
            buttonTitles: week, startIndex: 4)
        contentView.addSubview(codeSegmented)
        codeSegmented.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ChangeToIndex(index: Int) {
        print(index)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(_ viewModel: TrashCollectionModel){
        
    }
}
