//
//  SportsListVCTests.swift
//  SportiveTests
//
//  Created by iambavly on 3/30/21.
//

import XCTest
@testable import Sportive

class SportsListVCTests: XCTestCase {
    
    var vc : SportsListVC?
    var viewModel : SportsViewsModel?
    var mockUpApiClient : MockupApiClient?
    var promise : XCTestExpectation?

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: SportsListVC.self))
        vc?.loadViewIfNeeded()
        mockUpApiClient = MockupApiClient()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vc = nil
        viewModel = nil
        mockUpApiClient = nil
        try super.tearDownWithError()
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testVcNotNil() throws {
        vc = try XCTUnwrap(vc)
        XCTAssertNotNil(vc)
    }
    
    func testOutletsNotNil() throws {
        vc = try XCTUnwrap(vc)
        XCTAssertNotNil(vc?.collectionView)
        XCTAssertNotNil(vc?.profileName)
        XCTAssertNotNil(vc?.profilePic)
    }
    
    func testUserNameEqualUserDefault()throws {
        vc = try XCTUnwrap(vc)
        vc?.beginAppearanceTransition(true, animated: true)
        XCTAssertEqual(vc?.userName, UserDefaults.standard.string(forKey: "user_name"))
        let name  = "Hey \((vc?.userName)!)"
        XCTAssertEqual(vc?.profileName.text, name)
    }
    func testIfApiClientIsNilFails() {
        mockUpApiClient?.getData(endPoint: "SportsListStub", of: Sport.self, completion: {result in
            switch(result){
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                print(error)
            }
        })
        
        promise?.fulfill()
        
    }
    
    
//    func testCollectionViewNumberOfRowsEqItemListCount()throws {
//        let unWrapped = try XCTUnwrap(vc)
//        guard let collectionView = unWrapped.collectionView else {
//            return
//        }
//        let numOfItemsInSection = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)
//        XCTAssertEqual(numOfItemsInSection, unWrapped.items?.all.count)
//    }
    
}
