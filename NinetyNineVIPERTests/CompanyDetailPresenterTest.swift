//
//  CompanyDetailPresenterTest.swift
//  NinetyNineVIPERTests
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import XCTest
@testable import NinetyNineVIPER

class CompanyDetailPresenterTest: XCTestCase {

    //SUT
    var presenter: CompanyDetailPresenter!
    
    //Mocks
    private var view: MockCompanyDetailView!
    private var interactor: MockCompanyDetailInteractor!
    
    let givenCompanyID = 1
    
    override func setUp() {
        
        view = MockCompanyDetailView()
        interactor = MockCompanyDetailInteractor()
        
        presenter = CompanyDetailPresenter(view: view, interactor: interactor, companyID: givenCompanyID)
        
    }

    override func tearDown() {
        view = nil
        interactor = nil
        presenter = nil
    }
    
    func test_show_loading_when_view_did_load() {
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showLoadingCalled)
        
    }
    
    func test_load_company_with_given_id_when_view_did_load() {
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(interactor.loadCompanyCalled)
        XCTAssertEqual(interactor.loadCompanyID, givenCompanyID)
        
    }
    
    func test_hide_loading_when_load_company_success() {
        
        let givenCompany = Company(id: 1, name: "Apple", ric: "APPL", sharePrice: 123.123, description: "lorem ipsum", country: "EEUU")
        
        presenter.didLoadCompany(givenCompany)
        
        XCTAssertTrue(view.hideLoadingCalled)
        
    }
    
    func test_show_company_when_load_company_success() {
        
        let givenCompany = Company(id: 1, name: "Apple", ric: "APPL", sharePrice: 123.123, description: "lorem ipsum", country: "EEUU")
        
        presenter.didLoadCompany(givenCompany)
        
        XCTAssertTrue(view.showCompanyCalled)
        XCTAssertEqual(view.company, givenCompany)
    }
    
    func test_start_refreshing_company_process_when_load_company_success() {
        
        let givenCompany = Company(id: 1, name: "Apple", ric: "APPL", sharePrice: 123.123, description: "lorem ipsum", country: "EEUU")
        
        presenter.didLoadCompany(givenCompany)
     
        XCTAssertTrue(interactor.runRefreshProcessCalled)
        
    }
    
    func test_show_error_loading_company_when_load_company_fails() {
        
        presenter.didLoadCompanyError(.data)
        
        XCTAssertTrue(view.showErrorLoadCompanyCalled)
        
    }
    
    func test_hide_loading_when_load_company_fails() {
        
        presenter.didLoadCompanyError(.data)
        
        XCTAssertTrue(view.hideLoadingCalled)
    }
    
    private class MockCompanyDetailView: CompanyDetailView {
        var delegate: CompanyDetailViewDelegate?
        
        var showLoadingCalled = false
        var hideLoadingCalled = false
        var showCompanyCalled = false
        var company: Company? = nil
        var showErrorLoadCompanyCalled = false
        
        func showLoading() {
            showLoadingCalled = true
        }
        
        func hideLoading() {
            hideLoadingCalled = true
        }
        
        func showCompany(_ company: Company) {
            showCompanyCalled = true
            self.company = company
        }
        
        func showErrorLoadCompany() {
            showErrorLoadCompanyCalled = true
        }
    }
    
    private class MockCompanyDetailInteractor: CompanyDetailInteractorProtocol {
        var delegate: CompanyDetailInteractorDelegate?
        
        var loadCompanyCalled = false
        var loadCompanyID: Int? = nil
        var runRefreshProcessCalled = false
        
        func loadCompany(with id: Int) {
            loadCompanyCalled = true
            loadCompanyID = id
        }
        
        func runRefreshProcess() {
            runRefreshProcessCalled = true
        }
        
    }


}
