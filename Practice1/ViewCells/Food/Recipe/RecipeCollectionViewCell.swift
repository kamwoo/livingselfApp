//
//  RecipeCollectionViewCell.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/20.
//

import UIKit
import SDWebImage

class RecipeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecipeCollectionViewCell"
    
    private let imageView : UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: URL(string: "https://cdn.mkhealth.co.kr/news/photo/201806/img_MKH180615003_0.jpg"), completed: nil)
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
       let layer = CAGradientLayer()
        let colors: [CGColor] = [
            .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0),
            .init(red: 0, green: 0, blue: 0, alpha: 0.7)
        ]
        layer.colors = colors
        return layer
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "MapoPeacefull", size: 20)
        label.numberOfLines = 0
        label.text = "따끈하고 맛있는 온족발"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = contentView.height/20
        contentView.addSubview(imageView)
        contentView.layer.addSublayer(gradientLayer)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        gradientLayer.frame = contentView.bounds
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: contentView.width/10, y: contentView.height*3/5 , width: contentView.width*8/10, height: contentView.height/3)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
    }
    
    func configure(){
        
    }
    
}
