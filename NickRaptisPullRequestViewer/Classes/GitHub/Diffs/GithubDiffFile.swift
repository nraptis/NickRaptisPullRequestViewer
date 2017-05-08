//
//  DiffFile.swift
//  NickRaptisPullRequestViewer
//
//  Created by Nicholas Raptis on 5/7/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class GithubDiffFile: NSObject {
    
    var fileName: String = "__ ?? __"
    
    var isBinary: Bool = false
    
    //All Lines..
    var lines = [String]()
    
    //Broken down into "hunks."
    var hunks = [GithubDiffHunk]()
    
    var linePairs = [GithubDiffLinePair]()
    
    
    func load(_ fileLines: [String]) -> Bool {
        lines.removeAll()
        hunks.removeAll()
        linePairs.removeAll()
        
        for line in fileLines {
            if line.length > 0 {
                lines.append(line)
            }
        }
        
        if lines.count < 4 {
            return false
        }
        
        var _fileName = lines[0]
        
        _fileName.removeBefore("diff --git".length)
        if let fileNameStart = _fileName.findFirst(" a/"), let fileNameEnd = _fileName.findFirst(" b/") {
            _fileName.removeAfter(fileNameEnd)
            _fileName.removeBefore(fileNameStart + " a/".length)
            fileName = _fileName
        }
        
        for i in 1..<4 {
            let line = lines[i]
            if let _ = line.findFirstI("Binary") {
                isBinary = true
            }
        }
        
        
        
        
        var lineIndex: Int = 0
        
        while lineIndex < lines.count {
            
            let line = lines[lineIndex]
            
            if line.startsWith("@@") {
                
                let hunk = GithubDiffHunk()
                hunks.append(hunk)
                
                var firstLine = line
                
                firstLine.removeBefore(2)
                
                if let trailingAmps = firstLine.findFirstI("@@") {
                    
                    var lineNumberSequence = firstLine
                    lineNumberSequence.removeAfter(trailingAmps)
                    lineNumberSequence.removeLeadingAndTrailingSpaces()
                    let numberList = lineNumberSequence.toIntArray()
                    
                    if numberList.count >= 4 {
                        
                        if numberList[2] < 0 {
                            hunk.fromLineStart = abs(numberList[2])
                            hunk.fromLineLength = abs(numberList[3])
                            hunk.toLineStart = abs(numberList[0])
                            hunk.toLineLength = abs(numberList[1])
                        } else {
                            hunk.fromLineStart = abs(numberList[0])
                            hunk.fromLineLength = abs(numberList[1])
                            hunk.toLineStart = abs(numberList[2])
                            hunk.toLineLength = abs(numberList[3])
                        }
                    } else if numberList.count == 2 {
                        
                    }
                }
                
                lineIndex += 1
                while lineIndex < lines.count {
                    let hunkLine = lines[lineIndex]
                    if hunkLine.startsWith("@@") {
                        break
                    } else {
                        hunk.lines.append(hunkLine)
                        lineIndex += 1
                    }
                }
            } else {
                lineIndex += 1
            }
        }
        for hunk in hunks {
            hunk.findLinePairs()
            
            for linePair in hunk.linePairs {
                linePairs.append(linePair)
            }
        }
        
        return true
    }
    
    
    func printInfo() {
        
        print("==== GitHub Diff File ====")
        print("==== Start \(fileName) ====")
        
        for line in lines {
            print(line)
        }
        print("==== End \(fileName) ====")
    }

}
