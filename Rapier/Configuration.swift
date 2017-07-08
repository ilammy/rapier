// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import Foundation

/// OpenVPN configuration.
struct Configuration {
    var name: String
    var path: String
}

/// Initialize the configuration list.
func loadConfigurations() -> [Configuration] {
    // TODO: use application settings or something to store this hardcode
    return [
        Configuration(name: "Default", path: "~/Documents/openvpn.conf")
    ]
}
