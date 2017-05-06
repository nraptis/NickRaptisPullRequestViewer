//
//  FileUtils.swift
//
//  Created by Nicholas Raptis on 9/23/15.
//

import UIKit

open class FileUtils
{
    open class func saveImagePNG(image:UIImage?, filePath:String?) -> Bool {
        if image != nil {
            var imageData = UIImagePNGRepresentation(image!)
            if FileUtils.saveData(data: &imageData, filePath: filePath) {
                return true
            } else {
                print("Unable to save image (\(image!.size.width)x\(image!.size.height)) [\(filePath)]")
            }
        }
        return false
    }
    
    class func parseJSON(_ data: Data?) -> Any? {
        var result:Any?
        if(data != nil) {
            do {
                result = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
            } catch {
                print("JSON Serialization Failed")
            }
        }
        return result
    }
    
    
    
}


