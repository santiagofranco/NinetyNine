//
//  GetCompanyDetailUseCase.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

class GetCompanyDetailUseCase: ApiUseCase<GetCompanyDetailInput, GetCompanyDetailOutput> {
    
    override func endpoint(with input: GetCompanyDetailInput?) -> String {
        guard let input = input else {
            fatalError("Give me some input")
        }
        
        return "companies/\(input.id)"
    }
    
    override func getMethod() -> AbsNetMethod {
        return .get
    }
    
}

struct GetCompanyDetailInput: Codable {
    let id: Int
}

struct GetCompanyDetailOutput: Codable {
    let id: Int
    let name: String
    let ric: String
    let sharePrice: Double
    let description: String
    let country: String
}
