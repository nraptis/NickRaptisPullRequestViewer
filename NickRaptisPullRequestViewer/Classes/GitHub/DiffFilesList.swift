//
//  DiffFilesList.swift
//  NickRaptisPullRequestViewer
//
//  Created by Nicholas Raptis on 5/7/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class DiffFilesList: UIViewController, WebFetcherDelegate {

    
    internal var _diffFetcher: WebFetcher?
    var diffFetcher: WebFetcher {
        if _diffFetcher === nil {
            _diffFetcher = WebFetcher()
            _diffFetcher!.delegate = self
        }
        return _diffFetcher!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentPull = GithubAPI.shared.currentPull {
            diffFetcher.fetch(currentPull.diffURL)
        }
    }
    
    func fetchDidSucceed(fetcher: WebFetcher, result: WebResult) {
        
        if let data = diffFetcher.data {
            if let diff = String(bytes: data, encoding: .utf8) {
                print("Diff Data: \n~~~~~~ ~~~~~~ ~~~~~~\n");
                print(diff)
                print("\n~~~~~~ ~~~~~~ ~~~~~~\n")
                
                parseDiff(diff)
            }
        }
        
        //tableView.reloadData()
    }
    
    func fetchDidFail(fetcher: WebFetcher, result: WebResult) {
        print("Pulls - Fetch Failed [\(result)]")
        
    }
    
    func parseDiff(_ diff: String) {
        
        let lines = diff.components(separatedBy: "\n")
        
        let files = [[String]]()
        
        for i:Int in 0..<lines.count {
            let line = lines[i]
            print("Line \(i + 1): $\(line)")
            
            
            
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
