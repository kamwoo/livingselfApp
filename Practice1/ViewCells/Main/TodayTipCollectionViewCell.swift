//
//  TodayTipCollectionViewCell.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/11.
//

import UIKit

class TodayTipCollectionViewCell: UICollectionViewCell {
    static let identifier = "TodayTipCollectionViewCell"
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "오늘의 팁 ⭐️"
        label.textColor = .darkGray
        label.font = UIFont(name: "MapoPeacefull", size: 20)
        return label
    }()
    
    private let tipLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "MapoPeacefull", size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(tipLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tipLabel.sizeToFit()
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: contentView.bounds.width/10,
                                  y: contentView.bounds.height/4,
                                  width: contentView.bounds.width/2,
                                  height: contentView.bounds.height/7)
        tipLabel.frame = CGRect(x: titleLabel.left,
                                y: titleLabel.bottom+1,
                                width: contentView.bounds.width*8/10,
                                height: contentView.bounds.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tipLabel.text = ""
    }
    
    func configure(_ viewModel: todayTip){
        tipLabel.text = viewModel.tip
    }
}
