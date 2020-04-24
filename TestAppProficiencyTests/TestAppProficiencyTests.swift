//
//  TestAppProficiencyTests.swift
//  TestAppProficiencyTests
//
//  Created by user167484 on 3/17/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import XCTest
@testable import TestAppProficiency


class TestAppProficiencyTests: XCTestCase {
    var controller: InfoViewController?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controller = InfoViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testAlert() {
        enum CustomError: Error {
            case random
        }
        controller?.showAlert(error: CustomError.random)
    }
    
    
    func testDataFetch() {
        let expectation = XCTestExpectation(description: "fetchData")
        var datamodel: DataModel? = nil
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
//            expectation.fulfill()
//        }
        
        Request.mockData.execute(success: { (response, model: DataModel?) in
            datamodel = model
            expectation.fulfill()
        }, failure: { (error) in
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
        XCTAssert(datamodel != nil)
        XCTAssert(datamodel?.data?.count ?? 0 > 0)
        
        let cellDataModels = datamodel?.data?.compactMap({ (model) -> ImageCellViewModel? in
            return ImageCellViewModel(model: model)
        })
        XCTAssert(cellDataModels?.count ?? 0 > 0)
        
        let cell = ImageLoadTableViewCell()
        if let cellModel = cellDataModels?.first {
            cell.setup(viewModel: cellModel)
        }
    }

    
}
