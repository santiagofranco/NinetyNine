//
//  CompanyListPresenter.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import RxSwift

class CompanyListPresenter {
    
    let view: CompanyListView
    let interactor: CompanyListInteractorProtocol
    let router: CompanyListRouterProtocol
    
    private let disposeBag = DisposeBag()
    
    init(view: CompanyListView, interactor: CompanyListInteractorProtocol, router: CompanyListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.view.delegate = self
    }
    
    fileprivate func loadCompanies() {
        interactor.loadCompanies()
            .subscribe { event in
                switch event {
                case .next(let companies):
                    let sortedCompanies = companies.sorted {
                        return $0.sharePrice < $1.sharePrice
                    }
                    self.view.showCompanies(sortedCompanies)
                    self.view.hideLoading()
                    return
                case .error(let error):
                    self.view.hideLoading()
                    guard let error = error as? NNError else {
                        return
                    }
                    switch error {
                    case .header, .data:
                        self.view.showLoadingCompaniesError()
                    case .authentication:
                        self.view.showAuthenticationError()
                    }
                    return
                default:
                    return
                }
            }
            .disposed(by: disposeBag)
    }
    
}

extension CompanyListPresenter: CompanyListViewDelegate {
    func viewDidLoad() {
        view.showLoading()
        loadCompanies()
    }
    
    func didTap(company: Company) {
        router.openCompanyDetail(with: company)
    }
}
