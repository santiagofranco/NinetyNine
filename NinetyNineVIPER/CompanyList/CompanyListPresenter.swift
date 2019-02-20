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
    
    init(view: CompanyListView, interactor: CompanyListInteractor) {
        self.view = view
        self.interactor = interactor
        
        self.view.delegate = self
        self.interactor.delegate = self
    }
    
}

extension CompanyListPresenter: CompanyListViewDelegate {
    func viewDidLoad() {
        view.showLoading()
        interactor.loadCompanies()
    }
}

extension CompanyListPresenter: CompanyListInteractorDelegate {
    func didLoadCompanies(_ companies: [Company]) {
        view.showCompanies(companies)
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
