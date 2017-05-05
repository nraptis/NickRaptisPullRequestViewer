//
//  ViewController.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/4/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

//https://api.github.com/repositories?since=20000


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let ser = AFHTTPRequestSerializer()
        
        //https://api.github.com/user
        
        //Authorization
        
        //token ee80354928933bd4361e2894596f73dbd26362a1
        
        
        
        
        
        
        let urlString = "https://api.github.com/user"
        
        
        let dictionary = ["key1": [1,2,3], "key2": [2,4,6]]
        var data:Data? = nil
        
        do {
            try data = JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        } catch {
            print("Failz1")
        }
        
        let jsonString = String(data: data!, encoding: .utf8)
        let parameters = ["data" :  jsonString!]
        
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        
        var bodyData: Data? = nil
        do {
            try bodyData = JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print("Failz2")
        }
        
        request.httpBody = bodyData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bodyData!.count)", forHTTPHeaderField: "Content-Length")
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            let result = String(data: data!, encoding: .utf8)// NSString(data: data, encoding: NSUTF8StringEncoding)!
            print(result ?? "FAILZ3")
        }).resume()
        
        
        
        
        
        
        
        /*
        
        let urlString = "http://example.com/file.php"
        let dictionary = ["key1": [1,2,3], "key2": [2,4,6]]
        
        var data:Data? = nil
        
        do {
            try data = JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        } catch {
            print("Failz1")
        }
        
        let jsonString = String(data: data!, encoding: .utf8)
        let parameters = ["data" :  jsonString!]
        
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        
        var bodyData: Data? = nil
        do {
            try bodyData = JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print("Failz2")
        }
        
        request.httpBody = bodyData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bodyData!.count)", forHTTPHeaderField: "Content-Length")
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            let result = String(data: data!, encoding: .utf8)// NSString(data: data, encoding: NSUTF8StringEncoding)!
            print(result ?? "FAILZ3")
        }).resume()
        */
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

