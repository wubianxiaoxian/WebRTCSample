//
//  main.swift
//  SignalingServer
//
//  Created by kent.sun on 2023/5/15.
//

import Foundation

let server = try WebSocketServer()
server.start()
RunLoop.main.run()
