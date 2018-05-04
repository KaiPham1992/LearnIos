//
//  DemoUnitTestTests.swift
//  DemoUnitTestTests
//
//  Created by Kai Pham on 4/23/18.
//  Copyright © 2018 Kai Pham. All rights reserved.
//

import XCTest
@testable import DemoUnitTest

class DemoUnitTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetUsers() {
        let users = UserService().getUsers()
        
        XCTAssert(users.count == 2, "Ok OK")
    }
    
    func testServiceNotNil() {
        var controller = ViewController()
        controller.viewDidLoad()
        
        XCTAssertNotNil(controller.service, "user service is nil")
    }
    
}
