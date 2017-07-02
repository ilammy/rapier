// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import XCTest
import AppKit

@testable import Rapier

class ConfigurationListTests: XCTestCase {

    func testCallsUpdateWhenLoadingConfigurations() {
        let list = ConfigurationList()
        let observer = LeMonitor()

        list.subscribe(observer)

        XCTAssert(observer.updateCount == 0)

        list.loadConfigurations()

        XCTAssert(observer.updateCount == 1)
    }

    func testMultipleSubscriptions() {
        let list = ConfigurationList()
        let observer = LeMonitor()

        list.subscribe(observer)
        list.subscribe(observer)

        XCTAssert(observer.updateCount == 0)

        list.loadConfigurations()

        XCTAssert(observer.updateCount == 2)
    }

    func testUnsubscribing() {
        let list = ConfigurationList()
        let observer = LeMonitor()

        list.subscribe(observer)

        XCTAssert(observer.updateCount == 0)

        list.loadConfigurations()

        XCTAssert(observer.updateCount == 1)

        list.unsubscribe(observer)
        list.loadConfigurations()

        XCTAssert(observer.updateCount == 1)
    }
}

// TODO: mocking framework?
// TODO: file-private classes in Swift?
class LeMonitor: ConfigurationListObserver {
    var updateCount = 0

    func didUpdateConfigurationList() {
        updateCount += 1
    }
}
