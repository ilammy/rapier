// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import Foundation

/// Manages active VPN connections.
class VpnConnectionController {
    var connections: [VpnConnection] = []

    deinit {
        for connection in connections {
            connection.disconnect()
        }
    }

    func add(_ connection: VpnConnection) {
        connections.append(connection)
        connection.connect()
    }
}

/// VPN connection interface.
protocol VpnConnection {
    /// Initiate the connection.
    func connect()

    /// Terminate the connection.
    func disconnect()
}
