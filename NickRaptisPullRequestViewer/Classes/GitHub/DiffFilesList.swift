//
//  DiffFilesList.swift
//  NickRaptisPullRequestViewer
//
//  Created by Nicholas Raptis on 5/7/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class DiffFilesList: UIViewController, WebFetcherDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var diffFiles = [GithubDiffFile]()
    
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
        tableView.dataSource = self
        tableView.delegate = self
        if let currentPull = GithubAPI.shared.currentPull {
            diffFetcher.fetch(currentPull.diffURL)
        }
    }
    
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        var mask = UIInterfaceOrientationMask(rawValue: 0)
        mask = mask.union(.landscapeLeft)
        mask = mask.union(.landscapeRight)
        return mask
    }
    
    func fetchDidSucceed(fetcher: WebFetcher, result: WebResult) {
        
        if let data = diffFetcher.data {
            if let diff = String(bytes: data, encoding: .utf8) {
                //print("Diff Data: \n~~~~~~ ~~~~~~ ~~~~~~\n");
                //print(diff)
                //print("\n~~~~~~ ~~~~~~ ~~~~~~\n")
                
                parseDiff(diff)
            }
        }
        
        print("****   ****   ****")
        print("****   ****   ****")
        
        for diffFile in diffFiles {
            diffFile.printInfo()
        }
        
        
        tableView.reloadData()
    }
    
    func fetchDidFail(fetcher: WebFetcher, result: WebResult) {
        print("Pulls - Fetch Failed [\(result)]")
        
    }
    
    func parseDiff(_ diff: String) {
        
        let lines = diff.components(separatedBy: "\n")
        
        var fileLines = [String]()
        
        for i:Int in 0..<lines.count {
            let line = lines[i]
            //print("Line \(i + 1): \(line)")
            
            if line.startsWith("diff --git") {
                if fileLines.count > 0 {
                    addFile(fileLines)
                    fileLines.removeAll()
                }
            }
            
            fileLines.append(line)
            
                        
            
        }
        
        if fileLines.count > 0 {
            addFile(fileLines)
            fileLines.removeAll()
        }
        
        
    }
    
    func addFile(_ lines: [String]) {
        let diffFile = GithubDiffFile()
        if diffFile.load(lines) {
            diffFiles.append(diffFile)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let pull = pulls[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "pull_cell") as? PullTableViewCell
        if cell === nil {
            cell = PullTableViewCell(style: .default, reuseIdentifier: "pull_cell")
        }
        //cell!.labelTitle.text = pull.title
        //cell!.labelState.text = pull.state
        return cell!
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return diffFiles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let diffFile = diffFiles[section]
        
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.size.width, height: 70))
        headerView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        let headerTitleLabel = UILabel(frame: CGRect(x: 8.0, y: 8.0, width: headerView.frame.size.width - 16, height: headerView.frame.size.height - 16))
        headerTitleLabel.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        headerTitleLabel.font = UIFont(name: "Arial-BoldMT", size: 16.0)
        headerTitleLabel.numberOfLines = 0
        
        var title = diffFile.fileName
        if diffFile.isBinary {
            title = "[Binary] \(title)"
        }
        
        headerTitleLabel.text = title
        headerView.addSubview(headerTitleLabel)
        return headerView
    }
    
}
