// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, StatusMenuDelegate {
    @IBOutlet weak var statusMenuController: StatusMenuController!

    var configurations: [Configuration] = []

    private var _configurationDialog = AddConfigurationDialog()

    func applicationDidFinishLaunching(_ notification: Notification) {
        configurations = loadConfigurations()

        statusMenuController.delegate = self
        statusMenuController.configurations = configurations.map {$0.name}

        _configurationDialog.onSuccess = { name, path in
            NSLog("adding \(name) @ \(path)")
        }
    }

    func quitClicked() {
        NSApplication.shared().terminate(self)
    }

    func configurationClicked(_ index: Int) {
        NSLog("configuration \(index) clicked")
    }

    func addConfigurationClicked() {
        _configurationDialog.resetState()
        _configurationDialog.showWindow(self)
    }
}
