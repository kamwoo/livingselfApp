//
//  CheckDuesTableViewCell.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/13.
//

import UIKit

class CheckDuesTableViewCell: UITableViewCell {
    static let identifier = "CheckDuesTableViewCell"
    
    private var checkState = false
    
    private let dueName: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "MapoPeacefull", size: 20)
        return label
    }()
    
    private let dueDate: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "MapoPeacefull", size: 14)
        return label
    }()
    
    private let checkButton: UIButton = {
       let button = UIButton()
        let image = UIImage(systemName: "checkmark.circle",
                            withConfiguration: UIImage.SymbolConfiguration(
                                pointSize: 29, weight: .regular))
        button.setImage(image,for: .normal)
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(dueName)
        contentView.addSubview(dueDate)
        contentView.addSubview(checkButton)
        if checkState == false {
            checkButton.tintColor = .systemGray
        } else {
            checkButton.tintColor = .systemGreen
        }
        checkButton.addTarget(self, action: #selector(didTapCheckButton) , for: .touchUpInside)
    }
    
    @objc private func didTapCheckButton(){
        checkButton.pulsate()
        // 납부했는지 확인하고 갱신
        switch checkState {
        case false:
            checkState = true
            checkButton.tintColor = .systemGreen
        case true:
            checkState = false
            checkButton.tintColor = .systemGray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let view = contentView.bounds
        let lableHeight = view.height*2/3
        dueName.frame = CGRect(x: view.width/10,
                               y: view.height/2-lableHeight/2,
                               width: view.width/5,
                               height: lableHeight )
        dueDate.frame = CGRect(x: dueName.right,
                               y: view.height/2-lableHeight/2,
                               width: view.width/4,
                               height: lableHeight)
        let buttonSize = view.height*2/3
        checkButton.frame = CGRect(x: view.width - buttonSize - view.width/12,
                                   y: view.height - buttonSize - view.height/6,
                                   width: buttonSize,
                                   height: buttonSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dueName.text = ""
        dueDate.text = ""
        checkButton.tintColor = .systemGray
    }
    
    func configure(_ viewModel:checkDues){
        dueName.text = viewModel.dueName
        dueDate.text = DateFormatter.dateFormatter.string(from: viewModel.dueDate)
        checkState = viewModel.payCheck
    }

}
