//
//  CompanyListPresenterTest.swift
//  NinetyNineVIPERTests
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import XCTest
@testable import NinetyNineVIPER

class CompanyListPresenterTest: XCTestCase {

    //SUT
    var presenter: CompanyListPresenter!
    
    //Mocks
    private var interactor: MockCompanyListInteractor!
    private var view: MockCompanyListView!
    
    override func setUp() {
        
        view = MockCompanyListView()
        interactor = MockCompanyListInteractor()
        
        presenter = CompanyListPresenter(view: view, interactor: interactor)
    }

    override func tearDown() {
        interactor = nil
        presenter = nil
    }
    
    func test_show_loading_when_view_did_load() {
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showLoadingCalled)
        
    }
    
    func test_load_companies_when_view_did_load() {
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(interactor.loadCompaniesCalled)
    }
    
    func test_show_companies_when_load_companies_success() {
        
        let givenCompanies = [
            Company(id: 1, name: "Apple", ric: "APPL", sharePrice: 123.123),
            Company(id: 2, name: "Microsoft", ric: "MSFT", sharePrice: 456.345)
        ]
        
        presenter.didLoadCompanies(givenCompanies)
        
        XCTAssertTrue(view.showCompaniesCalled)
        XCTAssertEqual(view.companies.count, givenCompanies.count)
        
    }
    
    func test_hide_loading_when_load_companies_success() {
        let givenCompanies = [
            Company(id: 1, name: "Apple", ric: "APPL", sharePrice: 123.123),
            Company(id: 2, name: "Microsoft", ric: "MSFT", sharePrice: 456.345)
        ]
        
        presenter.didLoadCompanies(givenCompanies)
        
        XCTAssertTrue(view.hideLoadingCalled)
        
    }

    
    private class MockCompanyListView: CompanyListView {
        var delegate: CompanyListViewDelegate?
        
        var showLoadingCalled = false
        var showCompaniesCalled = false
        var companies: [Company] = []
        var hideLoadingCalled = false
        
        func showLoading() {
            showLoadingCalled = true
        }
        
        func showCompanies(_ companies: [Company]) {
            showCompaniesCalled = true
            self.companies = companies
        }
        
        func hideLoading() {
            hideLoadingCalled = true
        }
    }
    
    private class MockCompanyListInteractor: CompanyListInteractor {
        var delegate: CompanyListInteractorDelegate?
        
        var loadCompaniesCalled = false
        
        func loadCompanies() {
            loadCompaniesCalled = true
        }
    }


}
