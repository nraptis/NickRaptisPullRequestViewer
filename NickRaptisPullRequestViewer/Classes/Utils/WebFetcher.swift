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
        
        //print("Fetching URL: \(urlString!)")
        
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
