//
//  ViewController.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 30.09.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var viewModel: UserListViewModelProtocol!
    
    private let disposeBag = DisposeBag()
    private var showAnimatingCell = false
    
    private lazy var loadNextPageTrigger: Observable<Void> = {
        return self.usersTableView.rx.contentOffset
            .flatMap { (offset) -> Observable<Void> in
                let isNearBottomEdge = self.usersTableView.isNearBottomEdge()
                return isNearBottomEdge
                    ? Observable.just(Void())
                    : Observable.empty()
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = UserListViewModel(networkService: NetworkService(),
                                      loadNextPageTrigger: loadNextPageTrigger)
        
        registeTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
    }
}

private extension ViewController {
    func registeTableView() {
        UserCell.register(to: usersTableView)
        usersTableView.register(type: UserListFooterView.self)
        usersTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        viewModel.userListObservable
            .bind(to: usersTableView.rx.items(cellIdentifier: "UserCell",
                                                    cellType: UserCell.self)) {_, user, cell in
                                                        cell.nameLabel.text = user.firstName
        }.disposed(by: disposeBag)
        
        viewModel
            .isLoadingObservable
            .subscribe(onNext: { [weak self] isLoad in
                self?.showAnimatingCell = isLoad
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = usersTableView.dequeueReusableHeaderFooterView(with: UserListFooterView.self)
        showAnimatingCell ? footer.startLoadIndicator() : footer.stopLoadIndicator()
        footer.contentView.backgroundColor = .red
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserCell.cellHeight
    }
}

