// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var menu: NSMenu!

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)

    override func awakeFromNib() {
        statusItem.title = "Rapier"
        statusItem.menu = menu

        addConfigurations()
    }

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }

    private func addConfigurations() {
        let configurations = [("Default", "~/Documents/openvpn.conf")]; // TOOD: hardcode

        for (i, (confName, confPath)) in configurations.enumerated() {
            menu.insertItem(configurationItem(confName, confPath), at: i)
        }

        if configurations.count > 0 {
            menu.insertItem(NSMenuItem.separator(), at: configurations.count)
        }
    }

    private func configurationItem(_ name: String, _ path: String) -> NSMenuItem {
        let item = NSMenuItem()

        item.title = name
        item.keyEquivalent = path
        item.toolTip = path
        item.target = self
        item.action = #selector(StatusMenuController.configurationClicked(_:))
        item.state = 0

        return item
    }

    @objc private func configurationClicked(_ sender: NSMenuItem) {
        NSLog("configuration selected: \(sender.keyEquivalent)")

        sender.state = (sender.state != 0) ? 0 : 1;
    }
}
