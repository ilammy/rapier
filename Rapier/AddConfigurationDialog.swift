// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import Cocoa

class AddConfigurationDialog: NSWindowController, NSTextFieldDelegate {
    override var windowNibName: String? {
        return "AddConfigurationDialog"
    }

    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var locationTextField: NSTextField!
    @IBOutlet weak var addButton: NSButton!

    func resetState() {
        nameTextField?.stringValue = ""
        locationTextField?.stringValue = ""
        updateAddButtonState()
    }

    @IBAction func cancelClicked(_ sender: Any) {
        self.close()
    }

    @IBAction func selectClicked(_ sender: Any) {
        let dialog = NSOpenPanel()

        dialog.allowsMultipleSelection = false
        dialog.canChooseFiles = true
        dialog.canChooseDirectories = false

        dialog.title = "Select OpenVPN configuration"

        if dialog.runModal() == NSFileHandlingPanelOKButton {
            let url = dialog.urls.first!

            locationTextField?.stringValue = url.path
            updateAddButtonState()
        }
    }

    var onSuccess: ((_ name: String, _ path: String) -> Void)? = nil

    @IBAction func addClicked(_ sender: Any) {
        self.close()

        onSuccess?(nameTextField.stringValue, locationTextField.stringValue)
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        nameTextField?.delegate = self
        locationTextField?.delegate = self
    }

    override func controlTextDidChange(_ obj: Notification) {
        updateAddButtonState()
    }

    private func updateAddButtonState() {
        let nameEmpty = nameTextField.stringValue.isEmpty
        let pathEmpty = locationTextField.stringValue.isEmpty

        addButton.isEnabled = !nameEmpty && !pathEmpty
    }
}
