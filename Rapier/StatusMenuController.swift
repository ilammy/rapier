// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import Cocoa

class StatusMenuController: NSObject, ConfigurationListObserver {
    @IBOutlet weak var menu: NSMenu!

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)

    override func awakeFromNib() {
        statusItem.title = "Rapier"
        statusItem.menu = menu

        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        appDelegate.configurations.subscribe(self)
    }

    func didUpdateConfigurationList(_ configurations: [Configuration]) {
        addConfigurations(configurations)
    }

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }

    private func addConfigurations(_ configurations: [Configuration]) {
        // TODO: remove previously added configurations (if any)

        for (i, configuration) in configurations.enumerated() {
            menu.insertItem(configurationItem(configuration), at: i)
        }

        if configurations.count > 0 {
            menu.insertItem(NSMenuItem.separator(), at: configurations.count)
        }
    }

    private func configurationItem(_ configuration: Configuration) -> NSMenuItem {
        let item = NSMenuItem()

        item.title = configuration.name
        item.keyEquivalent = configuration.path
        item.toolTip = configuration.path
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
