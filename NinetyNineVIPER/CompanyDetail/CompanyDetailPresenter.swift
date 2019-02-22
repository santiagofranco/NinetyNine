//
//  CompanyDetailPresenter.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import RxSwift

class CompanyDetailPresenter {
    
    let view: CompanyDetailView
    let interactor: CompanyDetailInteractorProtocol
    let companyID: Int
    let disposeBag = DisposeBag()
    
    init(view: CompanyDetailView, interactor: CompanyDetailInteractorProtocol, companyID: Int) {
        self.view = view
        self.interactor = interactor
        self.companyID = companyID
        
        self.view.delegate = self
    }
    
}

extension CompanyDetailPresenter: CompanyDetailViewDelegate {
    
    func viewDidLoad() {
        view.showLoading()
        interactor.loadCompany(with: companyID)
            .subscribe { (event) in
                switch event {
                case .next(let company):
                    self.view.hideLoading()
                    self.view.showCompany(company)
                    return
                case .error:
                    self.view.showErrorLoadCompany()
                    self.view.hideLoading()
                    return
                default:
                    return
                }
        }.disposed(by: disposeBag)
    }
    
    func viewWillDisappear() {
        interactor.stopRefreshProcess()
    }
    
}
