//
//  ViewModel.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/02.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class ViewModel {
    lazy var menuObservable = BehaviorSubject<String>(value: "hello")
    
    private func Observ() -> Observable<String> {
        return Observable.create{ emitter in
            emitter.onNext("hello word")
            return Disposables.create()
        }
    }
    
    public func onClicked() {
        Observ()
            .bind(to: menuObservable)
    }
    
}
