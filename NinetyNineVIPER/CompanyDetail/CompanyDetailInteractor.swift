//
//  CompanyDetailInteractor.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import RxSwift

class CompanyDetailInteractor: CompanyDetailInteractorProtocol {
    
    private let getCompanyUseCase = GetCompanyDetailUseCase()
    private var currentId: Int? = nil
    private var shouldRefresh = true
    private let disposeBag = DisposeBag()
    
    func loadCompany(with id: Int) -> Observable<Company> {
        self.currentId = id
        return refreshCompany()
    }
    
    fileprivate func refreshCompany() -> Observable<Company> {
       return Observable<Int>.interval(3.0, scheduler: MainScheduler.instance)
            .takeWhile { _ in return self.shouldRefresh }
            .startWith(0)
            .flatMap { _ in
                Observable.create { observer -> Disposable in
                    
                    guard let companyID = self.currentId else {
                        observer.onError(NNError.data)
                        return Disposables.create()
                    }
                    
                    self.getCompanyUseCase.input = GetCompanyDetailInput(id: companyID)
                    
                    self.getCompanyUseCase.success = { companyOutput in
                        guard let output = companyOutput else {
                            return
                        }
                        
                        let company = Company(id: output.id,
                                              name: output.name,
                                              ric: output.ric,
                                              sharePrice: output.sharePrice,
                                              description: output.description,
                                              country: output.country)
                        
                        observer.onNext(company)
                        
                    }
                    
                    self.getCompanyUseCase.failure = { _ in
                        observer.onError(NNError.data)
                    }
                    
                    self.getCompanyUseCase.execute()
                    return Disposables.create()
                }
            }

    }
    
    func stopRefreshProcess() {
        shouldRefresh = false
    }
    
}
