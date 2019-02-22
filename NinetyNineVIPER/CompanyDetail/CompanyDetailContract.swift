//
//  CompanyDetailContract.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import RxSwift

protocol CompanyDetailView: class {
    var delegate: CompanyDetailViewDelegate? { get set }
    
    func showLoading()
    func hideLoading()
    func showCompany(_ company: Company)
    func showErrorLoadCompany()
}

protocol CompanyDetailViewDelegate: class {
    func viewDidLoad()
    func viewWillDisappear()
}

protocol CompanyDetailInteractorProtocol: class {
    
    func loadCompany(with id: Int) -> Observable<Company>
    func stopRefreshProcess()
}

