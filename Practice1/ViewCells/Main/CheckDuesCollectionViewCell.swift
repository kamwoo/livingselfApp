//
//  CheckDuesCollectionViewCell.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/11.
//

import UIKit

class CheckDuesCollectionViewCell: UICollectionViewCell {
    static let identifier = "CheckDuesCollectionViewCell"
    
    private var checkModels : [String] = []
    
    private let CheckTable: UITableView = {
        let table = UITableView()
        return table
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.addSubview(CheckTable)
        CheckTable.register(CheckDuesTableViewCell.self,
                            forCellReuseIdentifier: CheckDuesTableViewCell.identifier)
        CheckTable.delegate = self
        CheckTable.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CheckTable.frame = contentView.bounds
    }
    
    func configure(_ viewModel:[String]){
        checkModels = viewModel
        CheckTable.reloadData()
    }
    
}

extension CheckDuesCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CheckDuesTableViewCell.identifier,
                for: indexPath) as? CheckDuesTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = checkModels[indexPath.row]
        cell.configure(viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contentView.bounds.height/CGFloat(checkModels.count)
    }
    
}
