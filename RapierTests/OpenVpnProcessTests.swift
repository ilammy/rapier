// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import XCTest
import AppKit

@testable import Rapier

class OpenVpnProcessTests: XCTestCase {
    // We are cheating here a little with using /bin/echo, but this should be
    // okay for testing purposes.

    func testLaunchesExternalProcess() {
        let process = OpenVpnProcess("/bin/echo", "123")

        process.launch()
        process.wait()

        XCTAssert(true) // reachable
    }

    func testNotifiesAboutOutputAndTerminationViaDelegate() {
        let process = OpenVpnProcess("/bin/echo", "123")
        let monitor = Monitor()
        process.delegate = monitor

        process.launch()
        process.wait()

        XCTAssert(monitor.terminated)
        XCTAssert(monitor.output == "123\n")
        XCTAssert(monitor.errors == "")
    }

    func testCanBeLaunchedMultipleTimes() {
        let process = OpenVpnProcess("/bin/echo", "123")
        let monitor = Monitor()
        process.delegate = monitor

        process.launch()
        process.wait()

        process.launch()
        process.wait()

        XCTAssert(monitor.output == "123\n123\n")
    }
}

// TODO: replace with some proper mock
class Monitor: OpenVpnProcessDelegate {
    var output: String = ""
    var errors: String = ""
    var terminated: Bool = false

    func output(_ data: Data) {
        output += String(data: data, encoding: String.Encoding.utf8)!
    }

    func errors(_ data: Data) {
        errors += String(data: data, encoding: String.Encoding.utf8)!
    }

    func didTerminate() {
        terminated = true
    }
}
