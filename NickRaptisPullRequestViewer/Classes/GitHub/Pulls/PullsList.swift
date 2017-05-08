//
//  PullsList.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class PullsList: UIViewController, WebFetcherDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pulls = [GithubPull]()
    
    internal var _pullsFetcher: WebFetcher?
    var pullsFetcher: WebFetcher {
        if _pullsFetcher === nil {
            _pullsFetcher = WebFetcher()
            _pullsFetcher!.delegate = self
        }
        return _pullsFetcher!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        pullsFetcher.fetch(GithubAPI.shared.pullsURL)
    }
    
    func fetchDidSucceed(fetcher: WebFetcher, result: WebResult) {
        if let data = FileUtils.parseJSON(pullsFetcher.data) {
            if let pullsArray = data as? [[String: AnyObject]] {
                //Remove all previous pulls if there are any..
                pulls.removeAll()
                //Parse repo list.
                for repoInfo in pullsArray {
                    let pull = GithubPull()
                    //Load the JSON data.
                    pull.load(repoInfo)
                    //If it's valid, add it to the list.
                    if pull.title.characters.count > 0 {
                        pulls.append(pull)
                    }
                }
            }
        }
        tableView.reloadData()
    }
    
    func fetchDidFail(fetcher: WebFetcher, result: WebResult) {
        print("Pulls - Fetch Failed [\(result)]")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pulls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pull = pulls[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "pull_cell") as? PullTableViewCell
        if cell === nil {
            cell = PullTableViewCell(style: .default, reuseIdentifier: "pull_cell")
        }
        cell!.labelTitle.text = pull.title
        cell!.labelState.text = pull.state
        return cell!
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 0 && indexPath.row < pulls.count {
            let pull = pulls[indexPath.row]
            
            print("Selected Pull Title[\(pull.title)]")
            print("Selected Pull State[\(pull.state)]")
            print("Selected Pull URL[\(pull.diffURL)]")
            
            GithubAPI.shared.currentPull = pull
            
            //Selected Index Section[0] Row[0]
            //Selected Pull Title[Massive Sweeping Changes Pull]
            //Selected Pull State[open]
            //Selected Pull URL[https://github.com/nraptis/NickRaptisPullRequestViewer/pull/7.diff]
            
            self.performSegue(withIdentifier: "pulls_list_diff_files_list", sender: self)
        }
    }
}
