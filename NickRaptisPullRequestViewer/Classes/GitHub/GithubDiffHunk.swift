//
//  GithubDiffHunk.swift
//  NickRaptisPullRequestViewer
//
//  Created by Nicholas Raptis on 5/7/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class GithubDiffHunk: NSObject {
    
    var fromLineStart: Int = 0
    var fromLineLength: Int = 0
    
    var toLineStart: Int = 0
    var toLineLength: Int = 0
    
    var lines = [String]()
    
    var linePairs = [GithubDiffLinePair]()
    
    func append(left: [String], leftLine leftLineNumber: Int, right: [String], rightLine rightLineNumber: Int) {
        
        var maxCount = left.count
        if right.count > maxCount {
            maxCount = right.count
        }
        
        var lln = leftLineNumber
        var rln = rightLineNumber
        
        for i in 0..<maxCount {
            
            let pair = GithubDiffLinePair()
            linePairs.append(pair)

            var leftLine = ""
            var rightLine = ""
            
            if i<left.count && i<right.count {
                leftLine = left[i]
                rightLine = right[i]
                pair.leftHighlight = true
                pair.rightHighlight = true
                pair.leftLineNumber = lln
                pair.rightLineNumber = rln
            } else if i<left.count {
                leftLine = left[i]
                pair.leftHighlight = true
                pair.leftLineNumber = lln
                pair.rightLineNumber = -1
            } else {
                rightLine = right[i]
                pair.rightHighlight = true
                pair.leftLineNumber = -1
                pair.rightLineNumber = rln
            }
            
            pair.leftLine = leftLine
            pair.rightLine = rightLine
            
            lln += 1
            rln += 1
        }
    }
    
    func findLinePairs() {
        var lineLeft = fromLineStart
        var lineRight = toLineStart
        
        var leftLines = [String]()
        var rightLines = [String]()
        
        for line in lines {
            if line.startsWith("+") {
                rightLines.append(line)
            } else if line.startsWith("-") {
                leftLines.append(line)
            } else {
                
                if leftLines.count>0 || rightLines.count>0 {
                    append(left: leftLines, leftLine: lineLeft, right: rightLines, rightLine: lineRight)
                    lineLeft += leftLines.count
                    lineRight += rightLines.count
                    leftLines.removeAll()
                    rightLines.removeAll()
                }
                
                let pair = GithubDiffLinePair()
                linePairs.append(pair)
                
                pair.leftLine = line
                pair.rightLine = line
                
                pair.leftLineNumber = lineLeft
                pair.rightLineNumber = lineRight
                
                lineLeft += 1
                lineRight += 1
            }
        }
    }
}
