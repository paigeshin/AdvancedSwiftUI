//
//  AdvancedApp.swift
//  Advanced
//
//  Created by paige shin on 2023/02/13.
//

import SwiftUI

@main
struct AdvancedApp: App {

    let currentUserIsSignedIn: Bool
    
    init() {
//        let userIsSignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
//        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn") ? true : false
        let value = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"] == "true" ? true : false
        
        self.currentUserIsSignedIn = value
        print("current user signed in: \(self.currentUserIsSignedIn)")
    }
    
    var body: some Scene {
        WindowGroup {
            UITestingBootcampView(currentUserIsSignedIn: self.currentUserIsSignedIn)
        }
    }
}
