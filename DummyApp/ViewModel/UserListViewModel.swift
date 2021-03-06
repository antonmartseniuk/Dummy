//
//  UserListViewModel.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 01.10.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import XCoordinator

final class UserListViewModel: UserListViewModelProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let disposeBag = DisposeBag()
    
    private let isLoadingRelay: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    private let canFetchData: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    private let userListRelay: BehaviorRelay<[User]> = BehaviorRelay(value: [])
    var unownedRouter: UnownedRouter<MainAppRouter>?
    
    // MARK: - Output
    var isLoadingObservable: Observable<Bool>
    var userListObservable: Observable<[User]>
    
    // MARK: - Input
    var loadNextPageTrigger: Observable<Void>!
    
    private lazy var page: Observable<Int> = {
        func nextPage(_ previousPage: Int?) -> Observable<Int> {
            let last = previousPage ?? 0
            return Observable.just(last + 1)
                .delaySubscription(.milliseconds(300), scheduler: MainScheduler.instance)
        }

        func hasNext(_ page: Int?) -> Bool {
            guard let last = page else { return true }
            return last < 5
        }

        return Observable.page(make: nextPage, while: hasNext, when: self.loadNextPageTrigger)
    }()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.isLoadingObservable = self.isLoadingRelay.share()
        self.userListObservable = userListRelay.share()
    }
    
    func setPageTrigger(_ observable: Observable<Void>) {
        self.loadNextPageTrigger = observable
        observeTrigger()
        observePage()
    }
    
    func didSelectedRow(_ row: Int) {
        let user = userListRelay.value[row]
        unownedRouter?.trigger(.userProfile(id: user.id))
    }
}

extension UserListViewModel {
    func observePage() {
        Observable.zip(page, canFetchData.filter({$0}))
            .observeOn(MainScheduler.asyncInstance)
            
            .flatMap({ [weak self] page, can -> Observable<[User]> in
                guard let self = self else {
                    return Observable.empty()
                }
                return self.networkService.userListRequest(page: page)
            })
            .subscribe(onNext: { [weak self] users in
                self?.updateUserList(users)
                self?.canFetchData.accept(false)
            })
            .disposed(by: disposeBag)
        
        page
            .subscribe(onCompleted: { [weak self] in
                self?.isLoadingRelay.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func observeTrigger() {
        loadNextPageTrigger
            .subscribe(onNext: { [weak self] _ in
                self?.changeFetchDataIfNeed()
            }).disposed(by: disposeBag)
    }
}

extension UserListViewModel {
    func updateUserList(_ list: [User]) {
        var value = userListRelay.value
        value += list
        userListRelay.accept(value)
    }
    
    func changeFetchDataIfNeed() {
        if !canFetchData.value {
            canFetchData.accept(true)
        }
    }
}

