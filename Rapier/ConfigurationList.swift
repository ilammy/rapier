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

/// The list of available OpenVPN configurations.
class ConfigurationList {
    var configurations: [Configuration] = []
    var observers: [ConfigurationListObserver] = []

    /// Initialize the configuration list.
    func loadConfigurations() {
        // TODO: use application settings or something to store this hardcode
        configurations = [
            Configuration(name: "Default", path: "~/Documents/openvpn.conf")
        ]

        didUpdateConfigurationList()
    }

    /// Subscribe for notifications.
    ///
    /// The same observer can be subscribed multiple times. The notifications
    /// will be posted the number of times the observer has been subscribed.
    func subscribe(_ observer: ConfigurationListObserver) {
        observers.append(observer)
    }

    /// Unsubscribe from notifications.
    ///
    /// Removes one subscribtion for the observer. Does nothing if the observer
    /// is not subscribed.
    func unsubscribe(_ observer: ConfigurationListObserver) {
        if let index = observers.index(where: {$0 === observer}) {
            observers.remove(at: index)
        }
    }

    private func didUpdateConfigurationList() {
        for observer in observers {
            observer.didUpdateConfigurationList(self.configurations)
        }
    }
}

/// Receiver of notifications about configuration list changes.
protocol ConfigurationListObserver: class {
    /// Called when configuration list has been changed.
    func didUpdateConfigurationList(_ configurations: [Configuration])
}
