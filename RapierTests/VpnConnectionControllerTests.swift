// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import XCTest
import AppKit

@testable import Rapier

class VpnConnectionControllerTests: XCTestCase {
    func testConnectsConnectionsWhenAdded() {
        let controller = VpnConnectionController()

        let connection = LeConnection()

        controller.add(connection)

        XCTAssert(connection.connectCalled)
        XCTAssert(!connection.disconnectCalled)
    }

    func testDisconnectConnectionsWhenDestroyed() {
        let connection = LeConnection();

        {
            let controller = VpnConnectionController()

            controller.add(connection)
        }()

        XCTAssert(connection.disconnectCalled)
    }
}

// TODO: proper mocks
class LeConnection: VpnConnection {
    var connectCalled = false
    var disconnectCalled = false

    func connect() {
        connectCalled = true
    }

    func disconnect() {
        disconnectCalled = true
    }
}
