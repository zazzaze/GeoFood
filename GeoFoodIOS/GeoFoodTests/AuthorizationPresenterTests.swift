//
//  GeoFoodTests.swift
//  GeoFoodTests
//
//  Created by Егор on 15.03.2021.
//

import XCTest
@testable import GeoFood

class AuthorizationPresenterTests: XCTestCase {

    var presenter: AuthorizationPresenterProtocol!
    var authViewController: AuthorizationViewController!
    var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        authViewController = AuthorizationViewController()
        let newPresenter = AuthorizationPresenter(view: authViewController)
        newPresenter.router = AuthorizationRouter(view: authViewController)
        presenter = newPresenter
        authViewController.presenter = presenter
        navigationController = UINavigationController(rootViewController: authViewController)
    }

    func testTextFiledChanged_1() throws {
        presenter.textFieldChanged(email: "test", password: "123")
        XCTAssertFalse(authViewController.authorizationButton.isEnabled)
    }
    
    func testTextFiledChanged_2() throws {
        presenter.textFieldChanged(email: "egor@egor.com", password: "12345678E")
        XCTAssertTrue(authViewController.authorizationButton.isEnabled)
    }
}
