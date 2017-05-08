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
    
    func removeLeadingSpaces() -> String {
        return ""
    }
    
}




