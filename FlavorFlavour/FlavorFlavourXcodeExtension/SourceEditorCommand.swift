//
//  SourceEditorCommand.swift
//  FlavorFlavourXcodeExtension
//
//  Created by Ellen Shapiro (Work) on 9/6/16.
//  Copyright © 2016 Designated Nerd Software. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    enum Mode: String {
        case
        UStoUK,
        UKtoUS
    }
    
    enum WordSpelling: String {
        case
        flavor,
        behavior,
        color,
        center,
        program
    
        var USSpelling: String {
            return self.rawValue
        }
        
        var UKSpelling: String {
            switch self {
            case .flavor:
                return "flavour"
            case .behavior:
                return "behaviour"
            case .color:
                return "colour"
            case .center:
                return "centre"
            case .program:
                return "programme"
            }
        }
        
        func incorrectSpellingForMode(mode: Mode) -> String {
            switch mode {
            case .UStoUK:
                return self.USSpelling
            case .UKtoUS:
                return self.UKSpelling
            }
        }
        
        func correctSpellingForMode(mode: Mode) -> String {
            switch mode {
            case .UStoUK:
                return self.UKSpelling
            case .UKtoUS:
                return self.USSpelling
            }
        }
        
        //TODO: figure out a way to generate this automatically.
        static let allCases: [WordSpelling] = [
            .flavor,
            .behavior,
            .color,
            .center,
            .program
        ]
    }
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        
        guard
            let lastComponent = invocation.commandIdentifier.components(separatedBy: ".").last,
            let mode = Mode(rawValue: lastComponent) else {
                assertionFailure("Couldn't figure out mode!")
                completionHandler(nil)
                return
        }
        
        for index in 0..<invocation.buffer.lines.count {
            guard let line = invocation.buffer.lines[index] as? String else {
                continue
            }
            
            //Check if this is a simple comment
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard trimmed.hasPrefix("//") else {
                //Not a comment, keep going
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
        
        completionHandler(nil)
    }
}
