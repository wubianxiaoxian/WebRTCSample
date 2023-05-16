//
//  Logger+Extension.swift
//  ListDemo
//
//  Created by kent.sun on 2023/2/2.
//

import Foundation
import os.log

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let services = Logger(subsystem: subsystem, category: "services")
}
