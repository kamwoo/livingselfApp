//
//  ViewController.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/02.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
     
    let viewModel = ViewModel()
    
    var disposeBag = DisposeBag()
    
    private let titleLabel: UILabel = {
       let lable = UILabel()
        return lable
    }()
    
    private let button: UIButton = {
       let button = UIButton()
        button.setTitle("click", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(button)
        viewModel.menuObservable
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        viewModel.onClicked()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
    }

}

