// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import Cocoa

class AddConfigurationDialog: NSWindowController {
    override var windowNibName: String? {
        return "AddConfigurationDialog"
    }

    @IBOutlet weak var nameTextField: NSTextField?
    @IBOutlet weak var locationTextField: NSTextField?

    func resetState() {
        nameTextField?.stringValue = ""
        locationTextField?.stringValue = ""
    }

    @IBAction func cancelClicked(_ sender: Any) {
        self.close()
    }
}
