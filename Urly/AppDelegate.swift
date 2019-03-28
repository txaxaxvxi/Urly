//
//  AppDelegate.swift
//  Urly
//
//  Created by Taavi Roosimägi on 26/03/2019.
//  Copyright © 2019 Taavi Roosimägi. All rights reserved.
//  Talking-Muffin.com
//  Icon made by https://www.flaticon.com/authors/turkkub

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var urlyItem: NSStatusItem? = nil
    var credit: NSString? = nil
    func applicationDidFinishLaunching(_ aNotification: Notification) {
       urlyItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        urlyItem?.image = NSImage(named: "icon")
        let urlyMenu = NSMenu()
        urlyMenu.addItem(withTitle: "Make it a clickable URL", action: #selector(AppDelegate.urlyt), keyEquivalent: "");
        urlyMenu.addItem(withTitle: "BBCode", action: #selector(AppDelegate.bbcode), keyEquivalent: "")
        urlyMenu.addItem(withTitle: "Quit Urly…", action: #selector(AppDelegate.QuitUrly), keyEquivalent: "");
            urlyItem?.menu = urlyMenu
    }
    @objc func urlyt(){
        print ("HTTP URL")
       // PasteBoard()
        if let cp_items = NSPasteboard.general.pasteboardItems{
            for urlyItem in cp_items{
                for type in urlyItem.types{
                    if type.rawValue == "public.utf8-plain-text" {
                        if let urlString = urlyItem.string(forType:type){
                            NSPasteboard.general.clearContents()
                            var htmlurl = " "
                            if urlString.hasPrefix("http://") || urlString.hasPrefix("https://"){
                                htmlurl = urlString
                            }
                            else{
                                htmlurl = "http://\(urlString)"
                            }
                            
                            NSPasteboard.general.setString("<a href=\"\(htmlurl)\">\(urlString)<a/>" , forType: NSPasteboard.PasteboardType(rawValue: "public.html"))
                            PasteBoard()
                            NSPasteboard.general.setString(urlString, forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text"))
                        }
                    }
                }
            }
        }
    }
    @objc func QuitUrly(){
        NSApplication.shared.terminate(self)
    }
    func applicationWillTerminate(_ aNotification: Notification) {
       
    }
    func PasteBoard(){
        if let cp_items = NSPasteboard.general.pasteboardItems{
            for urlyItem in cp_items{
                for type in urlyItem.types{
                    print("Type: \(type)")
                    print("String: \(String(describing: urlyItem.string(forType: type)))")
                }
            }
        }
    }
    @objc func bbcode(){
        print ("BBCode")
        // PasteBoard()
        if let cp_items = NSPasteboard.general.pasteboardItems{
            for urlyItem in cp_items{
                for type in urlyItem.types{
                    if type.rawValue == "public.utf8-plain-text" {
                        if let urlString = urlyItem.string(forType:type){
                            NSPasteboard.general.clearContents()
                            var bbcurl = " "
                            if bbcurl.hasPrefix("http://") || urlString.hasPrefix("https://"){
                                bbcurl = urlString
                            }
                            else{
                                bbcurl = "http://\(urlString)"
                            }
                            //<a href=\"\(htmlurl)\">\(urlString)<a/>"
                            NSPasteboard.general.setString("<a href=\"\("bbcurl")\">\("[url=\(urlString)]Name of the link[/url]")<a/>" , forType: NSPasteboard.PasteboardType(rawValue: "public.html"))
                            PasteBoard()
                            NSPasteboard.general.setString(urlString, forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text"))
                        }
                    }
                }
            }
        }
    }
}
