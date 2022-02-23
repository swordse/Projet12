//
//  QuoteCoordinatorTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 21/02/2022.
//

import XCTest
@testable import Fabula

class QuoteCoordinatorTests: XCTestCase {
    
        var quoteCoordinator: QuoteCoordinator?
        
        override func setUpWithError() throws {
            quoteCoordinator = QuoteCoordinator(navigationController: UINavigationController())
        }

        override func tearDownWithError() throws {
            quoteCoordinator = nil
        }

    func testStart_WhenOK_ThenTopViewControllerIsAnecdotel() {
        
        quoteCoordinator?.start()
        
        XCTAssert((quoteCoordinator?.navigationController.topViewController as? QuoteViewController) != nil)
    }
    
    }
