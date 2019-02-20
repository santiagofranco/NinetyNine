//
//  CompanyListContract.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

protocol CompanyListView: class {
    var delegate: CompanyListViewDelegate? { get set }
    
    func showLoading()
    func showCompanies(_ companies: [Company])
    func hideLoading()
    func showLoadingCompaniesError()
    func showAuthenticationError()
}

protocol CompanyListViewDelegate: class {
    func viewDidLoad()
    func didTap(company: Company)
}

protocol CompanyListInteractorProtocol: class {
    var delegate: CompanyListInteractorDelegate? { get set }
    
    func loadCompanies()
    
}

protocol CompanyListInteractorDelegate: class {
    func didLoadCompanies(_ companies: [Company])
    func didLoadCompaniesError(_ error: NNError)
}

protocol CompanyListRouterProtocol: class {
    func openCompanyDetail(with company: Company)
}
