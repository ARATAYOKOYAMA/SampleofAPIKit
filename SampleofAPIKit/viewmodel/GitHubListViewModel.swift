//
//  GitHubListViewModel.swift
//  SampleofAPIKit
//
//  Created by 横山新 on 2019/02/24.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import APIKit

final class GitHubListViewModel {
    
//    private let viewWillAppearStream = PublishSubject<Void>()
//
//    var viewWillAppear: AnyObserver<()> {
//        return viewWillAppearStream.asObserver()
//    }
    
    private let repositoryStream = BehaviorRelay<[Repository]>(value: [])
    private let errorStream = BehaviorRelay<Error?>(value: nil)
    
    var error: Observable<Error?> {
        return errorStream.asObservable()
    }
    
    var repository: Observable<[Repository]> {
        return repositoryStream.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
    }
    
    func reloadData(userName: String) {
        let request = FetchRepositoryRequest(userName: userName)
        Session.rx_sendRequest(request: request)
            .subscribe {
                [weak self] event in
                switch event {
                case .next(let repos):
                    self?.repositoryStream.accept(repos)
                case .error(let error):
                    self?.errorStream.accept(error)
                default: break
                }
            }
            .disposed(by: disposeBag)
    }
}
