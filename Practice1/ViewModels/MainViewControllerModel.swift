//
//  MainViewControllerViewModel.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/05.
//

import Foundation
import RxSwift

class MainViewContollerModel {
    lazy var tipObservable = BehaviorSubject<String>(value: "여름철 쓰레기는 봉지단위로 묶어놓는게 좋다.")
    
    // 24시가 지나면 갱신
}
