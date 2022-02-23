//
//  MapCoordinatorTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 21/02/2022.
//
import XCTest
import MapKit
@testable import Fabula

class MapCoordinatorTests: XCTestCase {
    
        var mapCoordinator: MapCoordinator?
        
        override func setUpWithError() throws {
            mapCoordinator = MapCoordinator(navigationController: UINavigationController())
        }

        override func tearDownWithError() throws {
            mapCoordinator = nil
        }

    func testStart_WhenOK_ThenTopViewControllerIsAnecdotel() {
        
        mapCoordinator?.start()
        
        XCTAssert((mapCoordinator?.navigationController.topViewController as? MapViewController) != nil)
    }
    
        func testShowDetail_WhenOK_ThenTopViewControllerIsDetail() {
            
            mapCoordinator?.showDetailMap(annotation: ParisAnnotation(title: "ddd", locationName: "ddd", coordinate: CLLocationCoordinate2D(), text: "ddd"))
            
            XCTAssert((mapCoordinator?.navigationController.topViewController as? DetailMapViewController) != nil)
        }
    
    
    }
