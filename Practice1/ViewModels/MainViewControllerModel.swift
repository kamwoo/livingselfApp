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
    
    lazy var dueObservalbe = BehaviorSubject<[checkDues]>(value: [
        checkDues(dueName: "전기세", dueDate: Date(), payCheck: false),
        checkDues(dueName: "가스비", dueDate: Date(), payCheck: true),
        checkDues(dueName: "수도세", dueDate: Date(), payCheck: false),
        checkDues(dueName: "월세", dueDate: Date(), payCheck: true)
    ])
    
    lazy var trashObservable = BehaviorSubject<TrashCollectionModel>(value:
        TrashCollectionModel(currentDate: DateFormatter.dateFormatter.string(from: Date()),
                             generalTrashDate: ["월","수","금"],
                             recycleTrashDate: ["화","목","토"],
                             startDisposeTime: "16:00",
                             endDisposeTime: "21:00")
    )
}
