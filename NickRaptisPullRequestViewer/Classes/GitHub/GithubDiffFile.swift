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
    
    func load(_ fileLines: [String]) -> Bool {
        lines.removeAll()
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
            print("File Name = \(fileName)")
        }
        
        for i in 1..<4 {
            let line = lines[i]
            
            if let _ = line.findFirstI("Binary") {
                isBinary = true
            }
        }
        
        for line in lines {
        
            //if line.startsWith("@@")
            
        }
        
        
        //hunks
        
        
        //class GithubDiffHunk: NSObject {
        //    var fromLine1: Int = 0
        //    var fromLine2: Int = 0
            
        //    var toLine1: Int = 0
        
        //    var toLine2: Int = 0
            
        //    var lines = [String]()
        //}

        
        
        //diff --git a/NickRaptisPullRequestViewer.xcodeproj/project.xcworkspace/xcuserdata/nraptis.xcuserdatad/UserInterfaceState.xcuserstate b/NickRaptisPullRequestViewer.xcodeproj/project.xcworkspace/xcuserdata/nraptis.xcuserdatad/UserInterfaceState.xcuserstate
        //index 20f426e..084bfd3 100644
        //Binary files a/NickRaptisPullRequestViewer.xcodeproj/project.xcworkspace/xcuserdata/nraptis.xcuserdatad/UserInterfaceState.xcuserstate and b/NickRaptisPullRequestViewer.xcodeproj/project.xcworkspace/xcuserdata/nraptis.xcuserdatad/UserInterfaceState.xcuserstate differ
        
        
        //let myIntArrSafe = myStringArr.map { Int($0) ?? 0 }
        
        
        
        
        //let aIndex = line1.findFirst("a/")
        
        //line1.removeBefore(firstLineStart.length)
        
        //print("Index[\(aIndex)] From \(line1)")
        
        
        
        //@@ from-file-line-numbers to-file-line-numbers @@
        //line-from-either-file
        //line-from-either-file...
        
        
        //let line1
        
        //diff --git a/NickRaptisPullRequestViewer/Classes/ReposList.swift b/NickRaptisPullRequestViewer/Classes/ReposList.swift
        
        
        
        
        //class GithubDiffLinePair: NSObject {
        //    var leftLineNumber: Int = 0
        //    var leftLine: String = ""
        //    var rightLineNumber: Int = 0
        //    var rightLine: String = ""
        //}
        
        
        
        
        
        return true
    }
    
    
    func printInfo() {
        
        print("==== GitHub Diff File ====")
        print("==== Start \(fileName) ====")
        
        for line in lines {
            
            print(line)
            
        }
        
        
        print("==== End \(fileName) ====")
        
        /*
        Line 1: $diff --git a/NickRaptisPullRequestViewer.xcodeproj/project.xcworkspace/xcuserdata/nraptis.xcuserdatad/UserInterfaceState.xcuserstate b/NickRaptisPullRequestViewer.xcodeproj/project.xcworkspace/xcuserdata/nraptis.xcuserdatad/UserInterfaceState.xcuserstate
        Line 2: $index 20f426e..084bfd3 100644
        Line 3: $Binary files a/NickRaptisPullRequestViewer.xcodeproj/project.xcworkspace/xcuserdata/nraptis.xcuserdatad/UserInterfaceState.xcuserstate and b/NickRaptisPullRequestViewer.xcodeproj/project.xcworkspace/xcuserdata/nraptis.xcuserdatad/UserInterfaceState.xcuserstate differ
        Line 4: $diff --git a/NickRaptisPullRequestViewer/Classes/Device.swift b/NickRaptisPullRequestViewer/Classes/Device.swift
        Line 5: $index 298c08a..66f1d51 100755
        Line 6: $--- a/NickRaptisPullRequestViewer/Classes/Device.swift
        Line 7: $+++ b/NickRaptisPullRequestViewer/Classes/Device.swift
        Line 8: $@@ -78,4 +78,17 @@ class Device
        Line 9: $         if orientation == .landscapeLeft || orientation == .landscapeRight { return true }
        Line 10: $         return false
        Line 11: $     }
    Line 12: $+
    Line 13: $+    class var isInsane: Bool {
        Line 14: $+        return true
        Line 15: $+    }
    Line 16: $+
    Line 17: $+    class var isSilly: Bool {
        Line 18: $+        return true
        Line 19: $+    }
    Line 20: $+
    Line 21: $+    class var isRude: Bool {
        Line 22: $+        return false
        Line 23: $+    }
    Line 24: $+
    Line 25: $ }
Line 26: $diff --git a/NickRaptisPullRequestViewer/Classes/FileUtils.swift b/NickRaptisPullRequestViewer/Classes/FileUtils.swift
Line 27: $index 1b638c4..7eec320 100755
 
        */




    }

}
