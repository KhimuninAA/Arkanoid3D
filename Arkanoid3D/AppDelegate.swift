//
//  AppDelegate.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 31.07.2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate, NSMenuDelegate {

    @IBOutlet var window: NSWindow!
    var rootView: RootView?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        rootView = RootView()
        window.contentView = rootView
        window.delegate = self
        window.menu?.delegate = self
        self.window.title = NSLocalizedString("Mahjong 3D", comment: "")
        let wFrame = Storage.readWindowFrame()
        if wFrame.width > 50 && wFrame.height > 50 {
            window.setFrame(wFrame, display: true)
        }
        //test
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        sender.orderOut(self)
        //save window
        let frame = window.frame
        Storage.save(windowFrame: frame)
        return false
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}

