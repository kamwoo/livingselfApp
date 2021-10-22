//
//  FoodIconCollectionViewCell.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/16.
//

import UIKit

class FoodIconCollectionViewCell: UICollectionViewCell {
    static let identifier = "FoodIconCollectionViewCell"
    
    private let IconImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let IconNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "MapoPeacefull", size: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(IconImageView)
        contentView.backgroundColor = .clear
        contentView.addSubview(IconNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let IconWidth = contentView.bounds.width*2/3
        IconImageView.frame = CGRect(x: contentView.bounds.width/2 - IconWidth/2,
                                     y: 0,
                                     width: IconWidth,
                                     height: contentView.height*2/3)
        IconNameLabel.frame = CGRect(x: 0,
                                     y: IconImageView.bottom,
                                     width: contentView.bounds.width,
                                     height: contentView.bounds.height/3)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        IconImageView.image = nil
        IconNameLabel.text = ""
    }
    
    func configure(_ viewModel: FoodViewModel){
        IconImageView.image = UIImage(systemName: viewModel.foodIcon)
        IconNameLabel.text = viewModel.foodName
    }
}
