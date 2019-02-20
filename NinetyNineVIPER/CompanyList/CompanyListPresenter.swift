//
//  CompanyListPresenter.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

class CompanyListPresenter {
    
    let view: CompanyListView
    let interactor: CompanyListInteractor
    let router: CompanyListRouter
    
    init(view: CompanyListView, interactor: CompanyListInteractor, router: CompanyListRouter) {
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
        switch error {
        case .header:
            view.showLoadingCompaniesError()
        case .authentication:
            view.showAuthenticationError()
        }
    }
}
