//
//  String+URL.swift
//  CarSale
//
//  Created by Nicholas Raptis on 10/6/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

extension String {

    var length: Int {
        return characters.count
    }
    
    func startsWith(_ searchString: String?) -> Bool {
        if let string = searchString {
            if string.characters.count <= characters.count {
                let indexStart = index(startIndex, offsetBy: 0)
                let indexEnd = index(startIndex, offsetBy: string.characters.count)
                let startString = substring(with: indexStart..<indexEnd)
                return startString == string
            }
        }
        return false
    }
    
    mutating func removeBefore(_ removeIndex: Int) {
        if removeIndex >= length {
            //Do nothing
        } else if removeIndex <= 0 {
            self = ""
        } else {
            let indexStart = index(startIndex, offsetBy: removeIndex)
            let indexEnd = index(startIndex, offsetBy: length)
            self = substring(with: indexStart..<indexEnd)
        }
    }
    
    mutating func removeAfter(_ removeIndex: Int) {
        if removeIndex >= length {
            //Do nothing
        } else if removeIndex <= 0 {
            self = ""
        } else {
            let indexStart = index(startIndex, offsetBy: 0)
            let indexEnd = index(startIndex, offsetBy: removeIndex)
            self = substring(with: indexStart..<indexEnd)
        }
    }
    
    func findFirst(_ searchString: String?) -> Int? {
        if let string = searchString {
            if let r = range(of: string, options: .init(rawValue: 0) , range: nil, locale: nil) {
                return self.characters.distance(from: startIndex, to: r.lowerBound)
            }
        }
        return nil
    }
    
    func findLast(_ searchString: String?) -> Int? {
        if let string = searchString {
            if let r = range(of: string, options: .backwards , range: nil, locale: nil) {
                return self.characters.distance(from: startIndex, to: r.lowerBound)
            }
        }
        return nil
    }
    
    func findFirstI(_ searchString: String?) -> Int? {
        if let string = searchString {
            
            if let r = range(of: string, options: .caseInsensitive , range: nil, locale: nil) {
                return self.characters.distance(from: startIndex, to: r.lowerBound)
            }
        }
        return nil
    }
    
    func findLastI(_ searchString: String?) -> Int? {
        if let string = searchString {
            if let r = range(of: string, options: [.caseInsensitive, .backwards] , range: nil, locale: nil) {
                return self.characters.distance(from: startIndex, to: r.lowerBound)
            }
        }
        return nil
    }
    
    
    //let matches = matchesForRegexInText("[0-9]", text: string)
    
    func toIntArray() -> [Int] {
        var result = [Int]()
        let strings = matchesFor(regex: "-?[0-9][0-9]*")
        for string in strings {
            
            if let intValue = Int(string) {
                result.append(intValue)
        
                
            }
            
            }
        
        //return matchesFor(regex: "(^-?0\\.[0-9]*[1-9]+[0-9]*$)|(^-?[1-9]+[0-9]*((\\.[0-9]*[1-9]+[0-9]*$)|(\\.[0-9]+)))|(^-?[1-9]+[0-9]*$)|(^0$){1}")
        
        
        return result
    }
    
    
    func matchesFor(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let string = self as NSString
            let results = regex.matches(in: self, options: [], range: NSMakeRange(0, string.length))
            return results.map { string.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    /*
    func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        
        
        let regex = NSRegularExpression(pattern: regex, options: .init(rawValue: 0))
        
        
        //options: nil, error: nil)!
        let nsString = text as NSString
        let results = regex.matchesInString(text,
                                            options: nil, range: NSMakeRange(0, nsString.length))
            as! [NSTextCheckingResult]
        return map(results) { nsString.substringWithRange($0.range)}
    }
    */
    
    mutating func removeLeadingSpaces() {
        //Implement
    }
    
    mutating func removeTrailingSpaces() {
        self = replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
    }
    
    mutating func removeLeadingAndTrailingSpaces() {
        self = trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    //
    
    
}




