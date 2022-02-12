

import XCTest
import Firebase
@testable import TableViewTest


    class RequestServiceTests: XCTestCase {

        func testGetWords_WhenErrorOccured_ThenShouldReturnErrorOccured() {
            let session = FakeWordSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
            
            let wordService = WordService(session: session)
            
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            wordService.getWords(dataRequest: DataRequest.words.rawValue, callback: { result in
                
                guard case.failure(let failure) = result else {
                    XCTFail("Test getWords method with error response failed.")
                    return
                }
                XCTAssertEqual(failure, NetworkError.errorOccured)
                expectation.fulfill()
            })
            wait(for: [expectation], timeout: 0.01)
        }
        
        
        func testGetWords_WhenAllOk_ThenShouldReturnADefinition() {
            let session = FakeWordSession(fakeResponse: FakeResponse(result: FakeResponseData.resultWord, error: nil))
            
            let wordService = WordService(session: session)
            
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            wordService.getWords(dataRequest: DataRequest.words.rawValue, callback: { result in
                guard case.success(let success) = result else {
                    XCTFail("Test getWords method with correct response failed.")
                    return
                }
                XCTAssertEqual(success[0].definition, "ce qui définit")
                expectation.fulfill()
            })
            wait(for: [expectation], timeout: 0.01)
        }
        
        func testGetNewWords_WhenAllOk_ThenShouldReturnADefinition() {
            let session = FakeWordSession(fakeResponse: FakeResponse(result: FakeResponseData.resultWord, error: nil))
            
            let wordService = WordService(session: session)
            
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            wordService.getNewWords(dataRequest: DataRequest.words.rawValue, callback: { result in
                guard case.success(let success) = result else {
                    XCTFail("Test getWords method with correct response failed.")
                    return
                }
                XCTAssertEqual(success[0].definition, "ce qui définit")
                expectation.fulfill()
            })
            wait(for: [expectation], timeout: 0.01)
        }
    
    }
