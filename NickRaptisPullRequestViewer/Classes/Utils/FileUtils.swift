//
//  FileUtils.swift
//
//  Created by Nicholas Raptis on 9/23/15.
//

import UIKit

open class FileUtils
{
    open class var bundleDir: String {
        var result:String! = nil
        result = Bundle.main.resourcePath
        result = result + "/"
        return result
    }
    
    open class var docsDir: String {
        var result:String! = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        result = result + "/"
        return result
    }
    
    open class func getDocsPath(_ filePath:String?) -> String {
        var result = FileUtils.docsDir
        if let path = filePath { result = result + path }
        return result
    }
    
    open class func getBundlePath(_ filePath:String?) -> String {
        var result = FileUtils.bundleDir
        if let path = filePath { result = result + path }
        return result
    }
    
    open class func findAbsolutePath(_ filePath:String?) -> String {
        if let path = filePath , path.characters.count > 0 {
            if fileExists(path) {
                return path
            }
            let bundlePath = FileUtils.getBundlePath(path)
            if fileExists(bundlePath) {
                return bundlePath
            }
            let docsPath = FileUtils.getDocsPath(path)
            if fileExists(docsPath) {
                return docsPath
            }
            return path
        }
        return ""
    }
    
    class func fileExists(_ filePath:String?) -> Bool {
        if let path = filePath , path.characters.count > 0 {
            return FileManager.default.fileExists(atPath: path)
        }
        return false
    }
    
    open class func saveData(data:inout Data?, filePath:String?) -> Bool {
        if let path = filePath, data != nil {
            do {
                try data!.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
                return true
            } catch {
                print("Unable to save Data [\(path)]")
            }
        }
        return false
    }
    
    open class func loadData(_ filePath:String?) -> Data? {
        let path = FileUtils.findAbsolutePath(filePath)
        if path.characters.count >= 1 {
            return (try? Data(contentsOf: URL(fileURLWithPath: path)))
        }
        return nil
    }
    
    open class func deleteFile(_ filePath:String?) -> Void {
        
        let path = FileUtils.findAbsolutePath(filePath)
        if path.characters.count >= 1 {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                print("Unable to delete Data [\(path)]")
            }
        }
    }
    
    open class func copyFile(from filePath1: String?, to filePath2: String?) -> Void {
        print("Copying File\n[\(filePath1!)]\nto\n[\(filePath2!)]")
        if let path1 = filePath1, let path2 = filePath2 {
            if path1 != path2 {
                do {
                    try FileManager.default.copyItem(atPath: path1, toPath: path2)
                } catch {
                    print("Unable to copy file [\(path1)] to [\(path2)]")
                }
            }
        }
    }
    
    //Eventually we'll be wanting to bundle these images togther.
    open class func loadImage(_ filePath:String?) -> UIImage? {
        var image: UIImage?
        if let path = filePath {
            image = UIImage(named: path)
            
            if image == nil {
                
                //jpg, png, jpeg, JPG, PNG, JPEG, gif, GIF
                
            }
            
        }
        return image
    }
    
    open class func saveImagePNG(image:UIImage?, filePath:String?) -> Bool {
        if image != nil {
            var imageData = UIImagePNGRepresentation(image!)
            if FileUtils.saveData(data: &imageData, filePath: filePath) {
                return true
            } else {
                
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


