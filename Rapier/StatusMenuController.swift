// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var menu: NSMenu!

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)

    var delegate: StatusMenuDelegate?

    override func awakeFromNib() {
        statusItem.title = "Rapier"
        statusItem.menu = menu
    }

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        delegate?.quitClicked()
    }

    var configurations: [String] = [] {
        willSet(newConfigurations) {
            for index in (0..<configurations.count) {
                menu.removeItem(at: index)
            }
            for (index, name) in newConfigurations.enumerated() {
                menu.insertItem(configurationItem(name), at: index)
            }
        }
    }

    private func configurationItem(_ name: String) -> NSMenuItem {
        let item = NSMenuItem()

        item.title = name
        item.target = self
        item.action = #selector(StatusMenuController.configurationClicked(_:))
        item.state = 0

        return item
    }

    @objc private func configurationClicked(_ sender: NSMenuItem) {
        let index = menu.index(of: sender)

        delegate?.configurationClicked(index)
    }
}

protocol StatusMenuDelegate {
    func configurationClicked(_ index: Int)
    func quitClicked()
}
