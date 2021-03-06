//
//  CompanyListInteractor.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

/**
 
 This class contains all the access to data needed in this module.
 We use a protocol for this class, because we are injecting this implementation in the presenter.
 We can change easily this implementation without break nothing.
 
 */

class CompanyListInteractor: CompanyListInteractorProtocol {
    
    var delegate: CompanyListInteractorDelegate?
    
    let getCompaniesUseCase = GetCompaniesUseCase()
    
    func loadCompanies() {
        
        getCompaniesUseCase.success = { companiesOutput in
         
            guard let companiesOutput = companiesOutput else {
                self.delegate?.didLoadCompaniesError(.data)
                return
            }
            
            let companies = companiesOutput.compactMap { output in
                return Company(
                    id: output.id,
                    name: output.name,
                    ric: output.ric,
                    sharePrice: output.sharePrice
                )
            }
            self.delegate?.didLoadCompanies(companies)
        }
        
        getCompaniesUseCase.failure = { error in
            
            //We should map API error to corresponding business logic
            //.data is just an example
            self.delegate?.didLoadCompaniesError(.data)
        }
        
        getCompaniesUseCase.execute()
        
    }
    
    
}
