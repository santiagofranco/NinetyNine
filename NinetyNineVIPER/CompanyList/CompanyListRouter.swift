//
//  CompanyListRouter.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import UIKit

class CompanyListRouter: CompanyListRouterProtocol {
    
    let view: CompanyListViewController
    
    init(view: CompanyListViewController) {
        self.view = view
    }
    
    func openCompanyDetail(with company: Company) {
       view.navigationController?.pushViewController(CompanyDetailModule().provide(companyID: company.id), animated: true)
    }
}
