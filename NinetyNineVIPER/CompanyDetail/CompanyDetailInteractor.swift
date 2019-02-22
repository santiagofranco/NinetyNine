//
//  CompanyDetailInteractor.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation


/**
 
 This class contains all the access to data needed in this module.
 We use a protocol for this class, because we are injecting this implementation in the presenter.
 We can change easily this implementation without break nothing.
 
 */

class CompanyDetailInteractor: CompanyDetailInteractorProtocol {
    
    var delegate: CompanyDetailInteractorDelegate?
    
    let getCompanyUseCase = GetCompanyDetailUseCase()
    var refreshCompanyTimer: Timer? = nil
    var currentId: Int? = nil
    
    func loadCompany(with id: Int) {
        self.currentId = id
        getCompanyUseCase.input = GetCompanyDetailInput(id: id)
        
        getCompanyUseCase.success = { companyOutput in
            guard let output = companyOutput else {
                self.delegate?.didLoadCompanyError(.data)
                return
            }
            
            let company = Company(id: output.id,
                                  name: output.name,
                                  ric: output.ric,
                                  sharePrice: output.sharePrice,
                                  description: output.description,
                                  country: output.country)
            
            self.delegate?.didLoadCompany(company)
        }
        
        getCompanyUseCase.failure = { _ in
            //We should map API error to corresponding business logic
            //.data is just an example
            self.delegate?.didLoadCompanyError(.data)
        }
        
        getCompanyUseCase.execute()
        
    }
    
    func runRefreshProcess() {
        
        guard let companyID = self.currentId else {
            return
        }
        
        if self.refreshCompanyTimer?.isValid ?? false {
            return
        }
        
        self.refreshCompanyTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
            self.loadCompany(with: companyID)
        })
        
        
    }
    
}
