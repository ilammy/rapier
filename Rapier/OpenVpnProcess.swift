// Copyright (c) 2017, ilammy
//
// Licensed under MIT license (see LICENSE in the root directory). This file
// may be copied, distributed, and modified only in accordance with the terms
// specified by the chosen license.

import Foundation

/// Running OpenVPN process.
class OpenVpnProcess: VpnConnection {

    var delegate: OpenVpnProcessDelegate?

    private var binaryPath: String
    private var configPath: String
    private var process: Process?

    init(_ binary: String, _ config: String) {
        binaryPath = binary
        configPath = config
    }

    func launch() {
        if (process != nil) {
            return
        }

        process = Process()
        process!.launchPath = binaryPath
        process!.arguments = [configPath]
        process!.standardInput = nil
        process!.standardOutput = readingPipe({data in
            self.delegate?.output(data)
        })
        process!.standardError = readingPipe({data in
            self.delegate?.errors(data)
        })
        process!.terminationHandler = {_ in
            self.delegate?.didTerminate()
            self.process = nil
        }
        process!.launch()
    }

    func wait() {
        process?.waitUntilExit()
    }

    func terminate() {
        process?.terminate()
        process = nil
    }

    // MARK: - VpnConnection

    func connect() {
        launch()
    }

    func disconnect() {
        terminate()
    }
}

private func readingPipe(_ handle: @escaping ((Data) -> Void)) -> Pipe {
    let pipe = Pipe()
    pipe.fileHandleForReading.readabilityHandler = {_ in
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        handle(data)
    }
    return pipe
}

protocol OpenVpnProcessDelegate {
    /// Handle standard output stream of OpenVPN process.
    func output(_ data: Data)

    /// Handle standard errors stream of OpenVPN process.
    func errors(_ data: Data)

    /// Notification about OpenVPN process termination.
    func didTerminate()
}
