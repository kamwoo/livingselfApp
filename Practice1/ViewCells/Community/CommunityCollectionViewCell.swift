//
//  CommunityCollectionViewCell.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/21.
//

import UIKit

class CommunityCollectionViewCell: UICollectionViewCell {
    static let identifier = "CommunityCollectionViewCell"
    
    private let imageView : UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        label.numberOfLines = 0
        label.font = UIFont(name: "MapoPeacefull", size: 14)
        label.textColor = .white
        label.text = "나는 잘될 것을 알고있다.ㅁㅁ"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = contentView.width/18
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        titleLabel.frame = CGRect(x: 0, y: contentView.height*3/4, width: contentView.width, height: contentView.height/4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(image: UIImage){
        imageView.image = image
    }
}
