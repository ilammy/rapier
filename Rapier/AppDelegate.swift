// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var configurations: ConfigurationList = ConfigurationList()

    func applicationDidFinishLaunching(_ notification: Notification) {
        configurations.loadConfigurations()
    }
}
