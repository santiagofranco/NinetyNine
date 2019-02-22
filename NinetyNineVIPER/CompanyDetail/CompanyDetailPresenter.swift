//
//  CompanyDetailPresenter.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

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
    
    func viewWillDisappear() {
        interactor.stopRefreshProcess()
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
