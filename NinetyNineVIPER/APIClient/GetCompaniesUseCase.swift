//
//  GetCompaniesUseCase.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

class GetCompaniesUseCase: ApiUseCase<GetCompaniesInput, [GetCompaniesOutput]> {
    override func endpoint(with input: GetCompaniesInput?) -> String {
        return "companies"
    }
    
    override func getMethod() -> AbsNetMethod {
        return .get
    }
}


struct GetCompaniesInput: Codable {
    
}

struct GetCompaniesOutput: Codable {
    let id: Int
    let name: String
    let ric: String
    let sharePrice: Double
}
