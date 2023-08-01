//
//  AppDelegate.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 31.07.2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let levels = LevelUtils.getLevel(name: "LBreakout2")
        print(levels)
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

