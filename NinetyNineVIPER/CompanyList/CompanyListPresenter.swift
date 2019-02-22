//
//  CompanyListPresenter.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

/**
 
 Presenter contains all the presentation logic and decisions of the company list module.
 Presenter doesn't need a protocol for two reasons:
    1. We are not injecting this class anywhere. We are not going to break any dependency if we change something in this class.
    2. Any change of logic likely will cause changes in all dependencies.
 
 */

class CompanyListPresenter {
    
    let view: CompanyListView
    let interactor: CompanyListInteractorProtocol
    let router: CompanyListRouterProtocol
    
    init(view: CompanyListView, interactor: CompanyListInteractorProtocol, router: CompanyListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.view.delegate = self
        self.interactor.delegate = self
    }
    
}

extension CompanyListPresenter: CompanyListViewDelegate {
    func viewDidLoad() {
        view.showLoading()
        interactor.loadCompanies()
    }
    
    func didTap(company: Company) {
        router.openCompanyDetail(with: company)
    }
}

extension CompanyListPresenter: CompanyListInteractorDelegate {
    func didLoadCompanies(_ companies: [Company]) {
        let sortedCompanies = companies.sorted {
            return $0.sharePrice < $1.sharePrice
        }
        view.showCompanies(sortedCompanies)
        view.hideLoading()
    }
    
    func didLoadCompaniesError(_ error: NNError) {
        view.hideLoading()
        switch error {
        case .header, .data:
            view.showLoadingCompaniesError()
        case .authentication:
            view.showAuthenticationError()
        }
    }
}
