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
        cleanConfigurations()
        addConfigurations(configurations)
    }

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }

    private var configurationMenuItems: [NSMenuItem] = []

    private func cleanConfigurations() {
        for item in configurationMenuItems {
            menu.removeItem(item)
        }
        configurationMenuItems = []
    }

    private func addConfigurations(_ configurations: [Configuration]) {
        for (i, configuration) in configurations.enumerated() {
            let item = configurationItem(configuration)
            menu.insertItem(item, at: i)
            configurationMenuItems.append(item)
        }
    }

    private func configurationItem(_ configuration: Configuration) -> NSMenuItem {
        let item = NSMenuItem()

        item.title = configuration.name
        item.toolTip = configuration.path
        item.target = self
        item.action = #selector(StatusMenuController.configurationClicked(_:))
        item.state = 0

        return item
    }

    @objc private func configurationClicked(_ sender: NSMenuItem) {
        NSLog("configuration selected: \(sender.title) @ \(configurationMenuItems.index(of: sender) ?? -1)")

        sender.state = (sender.state != 0) ? 0 : 1;
    }
}
