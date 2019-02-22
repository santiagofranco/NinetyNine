//
//  CompanyListContract.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import RxSwift

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
    func loadCompanies() -> Observable<[Company]>
    
}

protocol CompanyListRouterProtocol: class {
    func openCompanyDetail(with company: Company)
}
