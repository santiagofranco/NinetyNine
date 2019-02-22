//
//  CompanyListPresenterTest.swift
//  NinetyNineVIPERTests
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import NinetyNineVIPER

class CompanyListPresenterTest: XCTestCase {

    //SUT
    var presenter: CompanyListPresenter!
    
    //Mocks
    private var interactor: MockCompanyListInteractor!
    private var view: MockCompanyListView!
    private var router: MockCompnayListRouter!
    
    //RX
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
        view = MockCompanyListView()
        interactor = MockCompanyListInteractor(scheduler: scheduler)
        router = MockCompnayListRouter()
        
        presenter = CompanyListPresenter(view: view, interactor: interactor, router: router)
    }

    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
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
        
        interactor.observable = Observable.create { observer -> Disposable in
            observer.onNext(givenCompanies)
            return Disposables.create()
        }
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showCompaniesCalled)
        XCTAssertEqual(view.companies.count, givenCompanies.count)
        
    }
    
    func test_show_ordered_companies_when_load_companies_success() {
        
        let givenCheaperCompany = Company(id: 1, name: "Apple", ric: "APPL", sharePrice: 123.123)
        let givenExpensiveCompany = Company(id: 2, name: "Microsoft", ric: "MSFT", sharePrice: 456.345)
        let givenMidCompany1 = Company(id: 3, name: "Alphabet", ric: "GOOG", sharePrice: 236.345)
        let givenMidCompany2 = Company(id: 4, name: "Amazon", ric: "AMZN", sharePrice: 389.345)
        
        let givenCompanies = [
            givenExpensiveCompany,
            givenMidCompany2,
            givenCheaperCompany,
            givenMidCompany1
        ]
        
        interactor.observable = Observable.create { observer -> Disposable in
            observer.onNext(givenCompanies)
            return Disposables.create()
        }
        
        presenter.viewDidLoad()
        
        XCTAssertEqual(view.companies[0], givenCheaperCompany)
        XCTAssertEqual(view.companies[1], givenMidCompany1)
        XCTAssertEqual(view.companies[2], givenMidCompany2)
        XCTAssertEqual(view.companies[3], givenExpensiveCompany)
        
        
    }
    
    func test_hide_loading_when_load_companies_success() {
        let givenCompanies = [
            Company(id: 1, name: "Apple", ric: "APPL", sharePrice: 123.123),
            Company(id: 2, name: "Microsoft", ric: "MSFT", sharePrice: 456.345)
        ]
        
        interactor.observable = Observable.create { observer -> Disposable in
            observer.onNext(givenCompanies)
            return Disposables.create()
        }
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.hideLoadingCalled)
        
    }

    func test_show_message_error_loading_companies_when_load_companie_fails() {
        
        let givenError: NNError = .header
        
        interactor.observable = Observable.create { observer -> Disposable in
            observer.onError(givenError)
            return Disposables.create()
        }
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showLoadingCompaniesErrorCalled)
        
    }
    
    
    func test_show_message_error_authentication_when_load_companies_fails_with_authentication_error() {
        
        let givenError: NNError = .authentication
        
        interactor.observable = Observable.create { observer -> Disposable in
            observer.onError(givenError)
            return Disposables.create()
        }
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showAuthenticationErrorCalled)
        
    }
    
    func test_hide_loading_when_load_companies_fails() {
        
        let givenError: NNError = .data
        
        interactor.observable = Observable.create { observer -> Disposable in
            observer.onError(givenError)
            return Disposables.create()
        }
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.hideLoadingCalled)
        
    }

    func test_open_company_details_when_user_taps_on_some_company() {
        
        let givenCompany = Company(id: 1, name: "Apple", ric: "APPL", sharePrice: 123.456)
        
        presenter.didTap(company: givenCompany)
        
        XCTAssertTrue(router.openCompanyDetailCalled)
        XCTAssertNotNil(router.company)
        XCTAssertEqual(router.company, givenCompany)
        
    }

    private class MockCompanyListView: CompanyListView {
        var delegate: CompanyListViewDelegate?
        
        var showLoadingCalled = false
        var showCompaniesCalled = false
        var companies: [Company] = []
        var hideLoadingCalled = false
        var showLoadingCompaniesErrorCalled = false
        var showAuthenticationErrorCalled = false
        
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
        
        func showLoadingCompaniesError() {
            showLoadingCompaniesErrorCalled = true
        }
        
        func showAuthenticationError() {
            showAuthenticationErrorCalled = true
        }
    }
    
    private class MockCompanyListInteractor: CompanyListInteractorProtocol {
       
        let scheduler: TestScheduler
        
        var observable: Observable<[Company]> = Observable.create { observer -> Disposable in
            observer.onCompleted()
            return Disposables.create()
        }
        var loadCompaniesCalled = false
        
        init(scheduler: TestScheduler) {
            self.scheduler = scheduler
        }
        
        func loadCompanies() -> Observable<[Company]> {
            loadCompaniesCalled = true
            return observable
        }
        
        

    }
    
    private class MockCompnayListRouter: CompanyListRouterProtocol {
        
        var openCompanyDetailCalled = false
        var company: Company? = nil
        
        func openCompanyDetail(with company: Company) {
            openCompanyDetailCalled = true
            self.company = company
        }
    }


}
