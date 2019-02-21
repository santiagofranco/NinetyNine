//
//  CompanyDetailContract.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

protocol CompanyDetailView: class {
    var delegate: CompanyDetailViewDelegate? { get set }
    
    func showLoading()
    func hideLoading()
    func showCompany(_ company: Company)
    func showErrorLoadCompany()
}

protocol CompanyDetailViewDelegate: class {
    func viewDidLoad()
}

protocol CompanyDetailInteractorProtocol: class {
    var delegate: CompanyDetailInteractorDelegate? { get set }
    
    func loadCompany(with id: Int)
    func runRefreshProcess()
}

protocol CompanyDetailInteractorDelegate: class {
    func didLoadCompany(_ company: Company)
    func didLoadCompanyError(_ error: NNError)
}
