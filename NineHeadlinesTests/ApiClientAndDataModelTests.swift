//
//  ApiClientAndDataModelTests.swift
//  NineHeadlinesTests
//
//  Created by Yi JIANG on 10/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

/* Comment: 
 This unit test is created after data layer coding, and before UI and bussiness logic coding.
 It helped me to varify the data model and Server manager are working well.
 */

import XCTest
@testable import NineHeadlines

class ApiClientAndModelTests: XCTestCase {
    
    var mockApiClient: MockApiClient!
    
    override func setUp() {
        super.setUp()
        mockApiClient = MockApiClient()
    }
    
    override func tearDown() {
        mockApiClient = nil
        super.tearDown()
    }
    
    func testVideoCatalogueApiService() {
        // Given
        let realApiClient = ApiClient()
        var responseModel: NewsResponse? = nil
        let expectation = self.expectation(description: "Parsing Succeeds")
        var commonError: CommonError? = nil
        var canDecode: Bool = true 
        
        // When
        realApiClient.networkRequest(.nineHeadlines) { apiResult in
            switch apiResult {
            case .success(let data):
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        responseModel = try decoder.decode(NewsResponse.self, from: data)
                    } catch {
                        canDecode = false
                    }
                }
            case .failure(let error):
                commonError = error
                XCTFail(error.description)
            }
            
            // Assert
            XCTAssert(commonError == nil, "Network request got error.")
            XCTAssert(canDecode == true, "Local Json should be decoded.")
            XCTAssert(responseModel != nil, "The API service's response data can't be decode by some reasons.")
            guard let responseModel = responseModel else { return }
            XCTAssert((responseModel.assets?.count ?? 0) > 0, "The API service responses empty data back.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) 
        
        
    }
    
    func testVideoCatalogueModelWithCorrectMockData() {
        // Given
        mockApiClient.jsonFileName = .responseSuccessWithAssets
        var responseModel: NewsResponse? = nil
        let expectation = self.expectation(description: "Parsing Succeeds")
        var commonError: CommonError? = nil
        var canDecode: Bool = true 
        
        // When
        mockApiClient.networkRequest(.nineHeadlines) { apiResult in
            switch apiResult {
            case .success(let data):
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        responseModel = try decoder.decode(NewsResponse.self, from: data)
                    } catch {
                        canDecode = false
                    }
                }
            case .failure(let error):
                commonError = error
            }
            
            // Assert
            XCTAssert(commonError == nil, "Network request got error.")
            XCTAssert(canDecode == true, "Local Json should be decoded.")
            XCTAssert(responseModel != nil, "The API service's response data can't be decode by some reasons.")
            guard let responseModel = responseModel else { return }
            XCTAssertTrue((responseModel.assets?.count ?? 0) > 0, "The mock data has THREE catalogues.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) 
    }
    
    func testVideoCatalogueModelWithEmpty() {
        // Given
        mockApiClient.jsonFileName = .responseSuccessEmptyAsset
        var responseModel: NewsResponse? = nil
        let expectation = self.expectation(description: "Parsing Succeeds")
        var commonError: CommonError? = nil
        var canDecode: Bool = true 
        
        // When
        mockApiClient.networkRequest(.nineHeadlines) { apiResult in
            switch apiResult {
            case .success(let data):
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        responseModel = try decoder.decode(NewsResponse.self, from: data)
                    } catch {
                        canDecode = false
                    }
                }
            case .failure(let error):
                commonError = error
            }
            
            // Assert
            XCTAssert(commonError == nil, "Network request got error.")
            XCTAssert(canDecode == true, "Local Json should be decoded.")
            XCTAssert(responseModel != nil, "The API service's response data can't be decoded by some reasons.")
            guard let responseModel = responseModel else { return }
            dump(responseModel)
            XCTAssertTrue(responseModel.assets?.isEmpty ?? false, "The mock data has ZERO catalogues.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) 
    }
    
    func testVideoCatalogueModelWithIncorrectMockData() {
        // Given
        mockApiClient.jsonFileName = .responseError
        var responseModel: NewsResponse? = nil
        let expectation = self.expectation(description: "Parsing Succeeds")
        var commonError: CommonError? = nil
        var canDecode: Bool = true 
        
        // When
        mockApiClient.networkRequest(.nineHeadlines) { apiResult in
            switch apiResult {
            case .success(let data):
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        responseModel = try decoder.decode(NewsResponse.self, from: data)
                    } catch {
                        canDecode = false
                    }
                    
                    dump(responseModel)
                }
            case .failure(let error):
                commonError = error
            }
            
            // Assert
            XCTAssert(commonError == nil, "Network request should get error.")
            XCTAssert(canDecode == false, "Local Json only have 404 response.")
            XCTAssert(responseModel == nil, "The API service's response data shouldn't be decoded.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) 
    }
}
