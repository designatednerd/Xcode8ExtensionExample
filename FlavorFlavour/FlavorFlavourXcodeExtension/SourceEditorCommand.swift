//
//  SourceEditorCommand.swift
//  FlavorFlavourXcodeExtension
//
//  Created by Ellen Shapiro (Work) on 9/6/16.
//  Copyright © 2016 Designated Nerd Software. All rights reserved.
//

import Foundation
import FlavorKit
import XcodeKit

//MARK: - Class definition

/**
 A single source editor command. You can have many of these in one extension.
 
 The class and its invocations are set up in Info.plist under XCSourceEditorCommandDefinitions. 
 */
class SourceEditorCommand: NSObject {

    /// This class doesn't do anything except conform to XCSourceEditorCommand. Keep scrolling!
}

// MARK: - XCSourceEditorCommand Protocol

extension SourceEditorCommand: XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        guard
            let lastComponent = invocation.commandIdentifier.components(separatedBy: ".").last,
            let mode = FlavorMode(rawValue: lastComponent) else {
                assertionFailure("Couldn't figure out mode!")
                completionHandler(nil)
                return
        }
        
        //Go through the lines in the buffer one by one
        for index in 0..<invocation.buffer.lines.count {
            guard let line = invocation.buffer.lines[index] as? String else {
                continue
            }
            
            //Check if this is a simple comment
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard trimmed.hasPrefix("//") else {
                //Not a comment, move on to the next line
                continue
            }
            
            var updatedLine = line
            for spelling in WordSpelling.allCases {
                let incorrect = spelling.incorrectSpellingForMode(mode: mode)
                if line.contains(incorrect) {
                    let correct = spelling.correctSpellingForMode(mode: mode)
                    updatedLine = updatedLine.replacingOccurrences(of: incorrect, with: correct)
                }
            }
            
            guard updatedLine != line else {
                //Nothing to replace, keep going.
                continue
            }
            
            //Replace the line at the given index.
            invocation.buffer.lines.replaceObject(at: index, with: updatedLine)
        }
        
        // Send a notification that will let the mac app know what happened
        let notificationWrapper = CFNotificationCenterWrapper()
        notificationWrapper.sendNotificationForMessage(withIdentifier: mode.rawValue)        
        
        completionHandler(nil)
    }
}
