//
//  WebFetcher.swift
//  CarSale
//
//  Created by Nicholas Raptis on 9/29/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import Foundation

enum WebResult: UInt32 { case pending = 0, success = 1, canceled = 2, error = 3, invalid = 4, timeout = 5 }

protocol WebFetcherDelegate
{
    func fetchDidSucceed(fetcher: WebFetcher, result: WebResult)
    func fetchDidFail(fetcher: WebFetcher, result: WebResult)
}

//Fetches JSON data asynchronously with parsing support.
class WebFetcher : NSObject, URLSessionDelegate
{
    var delegate: WebFetcherDelegate?
    
    var data: Data?
    
    var cachingPolicy: NSURLRequest.CachePolicy = .reloadRevalidatingCacheData
    var timeoutInterval: TimeInterval = 16.0
    
    private var sessionTask: URLSession?
    private var sessionDataTask: URLSessionDataTask?
    
    var isActive: Bool = false
    
    class func urlEscape(_ text: String?) -> String {
        if let unencoded = text {
            let allowedCharacters = CharacterSet(charactersIn: "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ0123456789")
            if let result = unencoded.addingPercentEncoding(withAllowedCharacters: allowedCharacters) {
                return result
            } else {
                return unencoded
            }
        }
        return ""
    }
    
    /*
    class func encrypt(string: String) -> String {
        if let data = string.data(using: .utf8), let keyData = encryptionKey.data(using: .utf8) {
            let paddingSize =  kCCBlockSizeAES128 - (data.count % 16);
            let dataLength = data.count + paddingSize
            var bytes = [UInt8](data)
            for _ in 0..<paddingSize {
                bytes.append(0)
            }
            let cryptData = NSMutableData(length: dataLength)!
            let keyLength: Int = size_t(kCCKeySizeAES256)
            let operation: CCOperation = UInt32(kCCEncrypt)
            let algoritm: CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options: CCOptions   = UInt32(0)
            let iv =  "514276FF19BEFFAD"
            var numBytesEncrypted :size_t = 0
            let cryptStatus = CCCrypt(operation, algoritm, options,
                                      [UInt8](keyData), keyLength,
                                      iv,
                                      //[UInt8](data), data.count,
                bytes, bytes.count,
                cryptData.mutableBytes, cryptData.length, &numBytesEncrypted)
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let base64cryptString = cryptData.base64EncodedData(options: Data.Base64EncodingOptions(rawValue: 0))
                if let result = String(data: base64cryptString, encoding: .utf8) {
                    return result
                }
            }
        }
        return string
    }
    
    class func decrypt(string: String) -> String {
        if let data = Data(base64Encoded: string, options: Data.Base64DecodingOptions(rawValue: 0)), let keyData = encryptionKey.data(using: .utf8) {
            let cryptData = NSMutableData(length: Int(data.count) + kCCBlockSizeAES128)!
            let keyLength: Int = size_t(kCCKeySizeAES256)
            let operation :CCOperation = UInt32(kCCDecrypt)
            let algoritm :CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options :CCOptions = UInt32(0)
            let iv = "514276FF19BEFFAD"
            var numBytesEncrypted :size_t = 0
            let cryptStatus = CCCrypt(operation, algoritm, options,
                                      [UInt8](keyData), keyLength,
                                      iv,
                                      [UInt8](data), data.count,
                                      cryptData.mutableBytes, cryptData.length, &numBytesEncrypted)
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                if let result = String(data: cryptData as Data, encoding: .utf8) {
                    return result
                }
            }
        }
        return string
    }
    */
    
    func clearTask() {
        if let task = sessionDataTask {
            task.cancel()
            sessionDataTask = nil
        }
        if let task = sessionTask {
            task.invalidateAndCancel()
            sessionTask = nil
        }
    }
    
    func clear() {
        clearTask()
        data = nil
    }
    
    internal func succeed() {
        clearTask()
        //Typically we want to notify the delegate once a fetch succeeds.
        delegate?.fetchDidSucceed(fetcher: self, result: .success)
    }
    
    internal func fail(result: WebResult) {
        clear()
        delegate?.fetchDidFail(fetcher: self, result: result)
    }
    
    func fetchDidComplete(_ data: Data) {
        //By default, we are successful.
        isActive = false
        succeed()
    }
    
    func fetch(_ urlString: String?) {
        
        isActive = true
        
        //Sanity check.
        guard urlString != nil else {
            isActive = false
            fail(result: .invalid)
            return
        }
        
        //Sanity check.
        guard let url = URL(string: urlString!) else {
            isActive = false
            fail(result: .invalid)
            return
        }
        
        let request = NSMutableURLRequest(url: url, cachePolicy: cachingPolicy, timeoutInterval: timeoutInterval)
        
        sessionTask = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        //Sanity check.
        guard sessionTask != nil else {
            isActive = false
            fail(result: .invalid)
            return
        }
        
        self.sessionDataTask = sessionTask!.dataTask(with: request as URLRequest, completionHandler:
            {
                [weak weakSelf = self] (data, response, error) -> Void in
                DispatchQueue.main.async {
                    if let checkSelf = weakSelf {
                        if data == nil || response == nil || error != nil {
                            //Something went wrong with the request...
                            checkSelf.isActive = false
                            checkSelf.fail(result: .error)
                        } else {
                            //Request completed!
                            checkSelf.isActive = false
                            checkSelf.data = data
                            checkSelf.fetchDidComplete(data!)
                        }
                    }
                }
            })
        
        //Sanity check.
        if let task = sessionDataTask {
            task.resume()
        } else {
            isActive = false
            fail(result: .invalid)
        }
    }
}
