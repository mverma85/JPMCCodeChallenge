//
//  JPMCCodeChallengeTests.swift
//  JPMCCodeChallengeTests
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import XCTest
@testable import JPMCCodeChallenge

class JPMCCodeChallengeTests: XCTestCase {
    
    var viewController: ISSViewController?
    let actions = ["viewDidLoad", "showError"]

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ISSViewController") as? ISSViewController
        _ = viewController?.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewController() {
        XCTAssertNotNil(viewController, "viewController is nil")
    }
    
    func testViewDidLoad() {
        viewController?.viewDidLoad()
        viewController?.viewWillAppear(true)
        XCTAssertNotNil(viewController?.tableView, "tableView cannot be nil")
    }
    
    func testCollectionViewViewDataSource() {
        XCTAssertNotNil(viewController!.tableView!.dataSource, "tableView dataSource cannot be nil")
    }
    
    func testCollectionViewDelegate() {
        XCTAssertNotNil(viewController!.tableView!.delegate, "tableView delegate cannot be nil")
    }

    func testRequiredActions() {
        for action in actions {
            let selector: Selector = Selector(action)
            let actionExists = viewController?.responds(to: selector)
            XCTAssertNotNil(actionExists, "\(action) does not exist")
        }
    }

    func testServiceCollectionViewCell() {
        // Register the cell
        let cell = viewController?.tableView.dequeueReusableCell(withIdentifier: "issTableViewCell")
        XCTAssertTrue(cell is ISSTableViewCell)
    }
    
    func testContactInfo() {
        let lat = "28.461910"
        let lon = "77.053182"
        let expectation = self.expectation(description: "Expectation for lan long")
        BusinessLayerManager.sharedManager.getISSPass(lat, lon: lon, handler: { [weak self] (inner) in
            guard let strongSelf = self else {
                return
            }
            do {
                let issPass = try inner()
                strongSelf.viewController?.issPass = issPass
                DispatchQueue.main.async {
                    strongSelf.viewController?.tableView.reloadData()
                    strongSelf.viewController?.tableView?.layoutIfNeeded()
                    strongSelf.issTableViewCell()
                    expectation.fulfill()
                }
            } catch {
                XCTFail("legServiceRequests not received")
            }
        })
        waitForExpectations(timeout: 300.0) { (error) in
            XCTAssertNil(error, "\(String(describing: error?.localizedDescription))")
        }
    }

    func issTableViewCell() {
        let cell = viewController?.tableView.dequeueReusableCell(withIdentifier: "issTableViewCell", for: IndexPath(row: 0, section: 0)) as! ISSTableViewCell
        
        if let issPass = viewController?.issPass?.first, let duration = issPass.duration {
            cell.durationLabel.text = "\(duration)"
            print("\(String(describing: cell.durationLabel.text)) - \(duration)")
            XCTAssertEqual(cell.durationLabel.text, "\(duration)")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
