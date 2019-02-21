//
//  CompanyListModule.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import UIKit

class CompanyListModule {
    
    lazy var view: CompanyListViewController = {
        CompanyListViewController()
    }()
    
    lazy var router: CompanyListRouterProtocol = {
        CompanyListRouter(view: self.view)
    }()
    
    lazy var interactor: CompanyListInteractorProtocol = {
        CompanyListInteractor()
    }()
    
    func provide() -> UIViewController {
       
        _ = CompanyListPresenter(view: self.view, interactor: self.interactor, router: self.router)
        
        return view
        
    }
    
}
