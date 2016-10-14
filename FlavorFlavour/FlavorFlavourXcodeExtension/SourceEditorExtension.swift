//
//  SourceEditorExtension.swift
//  FlavorFlavourXcodeExtension
//
//  Created by Ellen Shapiro (Work) on 9/6/16.
//  Copyright © 2016 Designated Nerd Software. All rights reserved.
//

import Foundation
import XcodeKit

//MARK: - Class Definition

/**
 The main class defining the extension.
 
 The class is set up in Info.plist under XCSourceEditorExtensionPrincipalClass.
 */
class SourceEditorExtension: NSObject {
    
    // Class doesn't actually do anyting except conform to XCSourceEditorExtension. Keep scrolling!
}

//MARK: - XCSourceEditorExtensionProtocol

extension SourceEditorExtension: XCSourceEditorExtension {
    
    func extensionDidFinishLaunching() {
        // An optional function to perform any work that needs to happen when Xcode launches.
        // Note that this isn't called when an extension is invoked, but when Xcode fires up.
    
        //You know, the critical stuff: 
        debugPrint("Extension did finish launching!")
    }
    
    /*
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        // Leaving commented out so it doesn't replace the .plist definitions I set up, but 
        // if there's anything you want to set up at runtime rather than in the plist, here's
        // where you would do it:
        return []
    }
    */
}
