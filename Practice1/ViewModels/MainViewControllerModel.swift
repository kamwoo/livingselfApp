//
//  MainViewControllerViewModel.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/05.
//

import Foundation
import RxSwift
import RxRelay

class MainViewContollerModel {
    let disposeBag = DisposeBag()
    
    lazy var tipObservable = BehaviorSubject<String>(value: "여름철 쓰레기는 봉지단위로 묶어놓는게 좋다.")
    
    lazy var dueObservalbe = BehaviorSubject<[String]>(value: [""])
    
    lazy var trashObservable = BehaviorSubject<TrashCollectionModel>(value:
        TrashCollectionModel(currentDate: DateFormatter.dateFormatter.string(from: Date()),
                             generalTrashDate: ["월","수","금"],
                             recycleTrashDate: ["화","목","토"],
                             startDisposeTime: "16:00",
                             endDisposeTime: "21:00")
    )
    
    private func dueObserv() -> Observable<[String]> {
        if UserDefaults.standard.stringArray(forKey: "DuesList") == nil {
            print("fetching-DuesList-nil")
            UserDefaults.standard.set(["전기세"], forKey: "DuesList")
            do {
                try UserDefaults.standard.setObject(checkDues(dueDate: "11", dueCheck: false), forKey:"전기세")
            }catch{
                print(error.localizedDescription)
            }
        }
        let dues = UserDefaults.standard.stringArray(forKey: "DuesList")
        return Observable.create{ emitter in
            emitter.onNext(dues!)
            return Disposables.create()
        }
    }
    
    public func dueFetching(){
        dueObserv()
            .bind(to: dueObservalbe)
            .disposed(by: disposeBag)
    }
    
    init(){
        dueFetching()
    }
    
    
}
