//
//  CompanyDetailPresenter.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

/**
 
 Presenter contains all the presentation logic and decisions of the company detail module.
 Presenter doesn't need a protocol for two reasons:
    1. We are not injecting this class anywhere. We are not going to break any dependency if we change something in this class.
    2. Any change of logic likely will cause changes in all dependencies.
 
 */

class CompanyDetailPresenter {
    
    let view: CompanyDetailView
    let interactor: CompanyDetailInteractorProtocol
    let companyID: Int
    
    init(view: CompanyDetailView, interactor: CompanyDetailInteractorProtocol, companyID: Int) {
        self.view = view
        self.interactor = interactor
        self.companyID = companyID
        
        self.view.delegate = self
        self.interactor.delegate = self
    }
    
}

extension CompanyDetailPresenter: CompanyDetailViewDelegate {
    
    func viewDidLoad() {
        view.showLoading()
        interactor.loadCompany(with: companyID)
    }
    
}

extension CompanyDetailPresenter: CompanyDetailInteractorDelegate {
    func didLoadCompany(_ company: Company) {
        view.hideLoading()
        view.showCompany(company)
        interactor.runRefreshProcess()
    }
    
    func didLoadCompanyError(_ error: NNError) {
        view.showErrorLoadCompany()
        view.hideLoading()
    }
}
