//
//  InserButtonCollectionViewCell.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/11/04.
//

import UIKit

protocol InserButtonCollectionViewCellDelegate : AnyObject {
    func didTapPlusButton()
}

class InserButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "InserButtonCollectionViewCell"
    
    weak var delegate: InserButtonCollectionViewCellDelegate?
    
    private let IconImageView : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .link
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(IconImageView)
        IconImageView.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton(){
        delegate?.didTapPlusButton()
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
        IconImageView.layer.cornerRadius = IconWidth/2
    }
    
    
}
