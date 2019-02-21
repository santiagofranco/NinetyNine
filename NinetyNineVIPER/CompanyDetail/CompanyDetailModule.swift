//
//  CompanyDetailModule.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import UIKit

class CompanyDetailModule {
    
    lazy var view: CompanyDetailViewController = {
        CompanyDetailViewController()
    }()
    
    lazy var interactor: CompanyDetailInteractorProtocol = {
        CompanyDetailInteractor()
    }()
    
    
    func provide(companyID: Int) -> UIViewController {
        _ = CompanyDetailPresenter(view: view, interactor: interactor, companyID: companyID)
        return view
    }
    
}
