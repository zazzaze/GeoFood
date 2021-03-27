//
//  AuthorizationViewControllerTests.swift
//  GeoFoodTests
//
//  Created by Егор on 15.03.2021.
//

import XCTest
@testable import GeoFood

class AuthorizationViewControllerTests: XCTestCase {

    let authVC: AuthorizationViewProtocol! = AuthorizationViewController()

    func testSetAuthorizationButtonIsEnabled_1() throws {
        authVC.setAuthorizationButtonIsEnabled(false)
        XCTAssertFalse((authVC as! AuthorizationViewController).authorizationButton.isEnabled)
    }
    
    func testSetAuthorizationButtonIsEnabled_2() throws {
        authVC.setAuthorizationButtonIsEnabled(true)
        XCTAssertTrue((authVC as! AuthorizationViewController).authorizationButton.isEnabled)
    }
}
