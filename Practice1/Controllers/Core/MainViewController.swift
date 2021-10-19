//
//  MainViewController.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/05.
//

import Foundation
import UIKit
import RxSwift

enum MainSectionType {
    case todayTip(viewModels: [todayTip])
    case checkDues(viewModels: [[checkDues]])
    case TrashCollection(viewModels: [TrashCollectionModel])
}

class MainViewController: UIViewController {
    private let viewModel = MainViewContollerModel()
    
    private var mainSections = [MainSectionType]()
    
    private var disposBag = DisposeBag()
    
    // MARK: - UI
    
    private let TopView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 246/255, green: 238/255, blue: 221/255, alpha: 1)
        return view
    }()
    
    private let LocationButton: UIButton = {
       let button = UIButton()
        button.setTitle("울산광역시 남구 무거동", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "MapoPeacefull", size: 22)
        return button
    }()
    
    private let MainCollectionView: UICollectionView = {
        let collectoinView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout{ sectionIdx, _ ->  NSCollectionLayoutSection in
                return MainViewController.createSectionLayout(section: sectionIdx)
            })
        collectoinView.backgroundColor = .systemBackground
        return collectoinView
    }()
    
    private static func createSectionLayout(section:Int) -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 2, trailing: 12)
        
        switch section {
        case 1:
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        case 2:
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        default:
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.35)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        
    }
    
    // MARK: - functions

    @objc private func didTapLocationLabel(){
        print("MainViewController - didTapLocationLabel, clicked")
        let actionSheet = UIAlertController(title: "나의 위치",
                                            message: "현재 위치를 변경하시겠습니까?",
                                                    preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: nil))
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
        MainCollectionViewConfigure()
        Modelconfigure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disposBag = DisposeBag()
    }
    
    private func Modelconfigure(){
        viewModel.tipObservable
            .subscribe(onNext: {tipText in
                self.mainSections.append(.todayTip(viewModels: [todayTip(tip: tipText)]))
            })
            .disposed(by: disposBag)
        
        viewModel.dueObservalbe
            .subscribe(onNext: { dues in
                self.mainSections.append(.checkDues(viewModels: [dues]))
            })
            .disposed(by: disposBag)
        
        viewModel.trashObservable
            .subscribe(onNext: { trashCollection in
                self.mainSections.append(.TrashCollection(viewModels:[trashCollection]))
            })
            .disposed(by: disposBag)
    }
    
    private func MainCollectionViewConfigure(){
        view.addSubview(MainCollectionView)
        MainCollectionView.backgroundColor = UIColor(displayP3Red: 246/255, green: 238/255, blue: 221/255, alpha: 1)
        MainCollectionView.register(TodayTipCollectionViewCell.self,
                                    forCellWithReuseIdentifier: TodayTipCollectionViewCell.identifier)
        MainCollectionView.register(CheckDuesCollectionViewCell.self,
                                    forCellWithReuseIdentifier: CheckDuesCollectionViewCell.identifier)
        MainCollectionView.register(TrashCollectionViewCell.self,
                                    forCellWithReuseIdentifier: TrashCollectionViewCell.identifier)
        MainCollectionView.delegate = self
        MainCollectionView.dataSource = self
    }
    
    private func configure(){
        view.addSubview(TopView)
        view.addSubview(LocationButton)
        LocationButton.addTarget(self, action: #selector(didTapLocationLabel), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        LocationButton.frame = CGRect(x: 0,
                                      y: view.bounds.height/18,
                                      width: view.bounds.width,
                                      height: view.bounds.height/15)
        TopView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/8)
        MainCollectionView.frame = CGRect(x:0,
                                          y: TopView.bottom,
                                          width: view.bounds.width,
                                          height: view.bounds.height-TopView.height)
    }
    
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        mainSections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = mainSections[section]
        switch type {
        case .todayTip(let tipModel):
            return tipModel.count
        case .checkDues(let checkModel):
            print(checkModel.count)
            return checkModel.count
        case .TrashCollection(let trashModel):
            return trashModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = mainSections[indexPath.section]
        switch type {
        case .todayTip(let tipModel):
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TodayTipCollectionViewCell.identifier,
                    for: indexPath) as? TodayTipCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = tipModel[indexPath.row]
            cell.configure(viewModel)
            return cell
            
        case .checkDues(let checkModel):
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CheckDuesCollectionViewCell.identifier,
                    for: indexPath) as? CheckDuesCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = checkModel[indexPath.row]
            cell.configure(viewModel)
            return cell
            
        case .TrashCollection(let trashModel):
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TrashCollectionViewCell.identifier,
                    for: indexPath) as? TrashCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = trashModel[indexPath.row]
            cell.configure(viewModel)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }
}
