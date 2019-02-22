//
//  CompanyListInteractor.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import RxSwift

class CompanyListInteractor: CompanyListInteractorProtocol {
    
    let getCompaniesUseCase = GetCompaniesUseCase()
    
    func loadCompanies() -> Observable<[Company]> {
        return Observable.create { observer -> Disposable in
            
            self.getCompaniesUseCase.success = { companiesOutput in
                
                guard let companiesOutput = companiesOutput else {
                    observer.onError(NNError.data)
                    return
                }
                
                let companies = companiesOutput.map { output in
                    return Company(
                        id: output.id,
                        name: output.name,
                        ric: output.ric,
                        sharePrice: output.sharePrice
                    )
                }
                
                observer.on(.next(companies))
                observer.onCompleted()
            }
            
            self.getCompaniesUseCase.failure = { error in
                observer.onError(NNError.data)
            }
            
            self.getCompaniesUseCase.execute()
            
            return Disposables.create()
        }
    }
    
    
}
