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
    UserDefaults.standard.register(defaults: [
        // TODO: set default to empty
        "Configurations": [
            ["name": "Default", "path": "/Users/ilammy/Documents/openvpn.conf"],
        ]
    ])

    var configurations: [Configuration] = []

    for entry in UserDefaults.standard.array(forKey: "Configurations") ?? [] {
        if let dict = entry as? [String: String] {
            let (name, path) = (dict["name"], dict["path"])
            if name != nil && path != nil {
                configurations.append(Configuration(name: name!, path: path!))
            }
        }
    }

    return configurations
}
