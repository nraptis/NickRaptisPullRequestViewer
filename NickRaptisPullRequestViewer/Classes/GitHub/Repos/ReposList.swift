//
//  ReposList.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class ReposList: UIViewController, WebFetcherDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var repos = [GithubRepo]()
    
    internal var _reposFetcher: WebFetcher?
    var reposFetcher: WebFetcher {
        if _reposFetcher === nil {
            _reposFetcher = WebFetcher()
            _reposFetcher!.delegate = self
        }
        return _reposFetcher!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        reposFetcher.fetch(GithubAPI.shared.reposURL)
    }
    
    func fetchDidSucceed(fetcher: WebFetcher, result: WebResult) {
        if let data = FileUtils.parseJSON(reposFetcher.data) {
            if let reposArray = data as? [[String: AnyObject]] {
                //Remove all previous repos if there are any..
                repos.removeAll()
                
                //Parse repo list.
                for repoInfo in reposArray {
                    let repo = GithubRepo()
                    //Load the JSON data.
                    repo.load(repoInfo)
                    
                    //If it's valid, add it to the list.
                    if repo.name.characters.count > 0 {
                        repos.append(repo)
                    }
                }
            }
        }
        tableView.reloadData()
    }
    
    func fetchDidFail(fetcher: WebFetcher, result: WebResult) {
        print("Users - Fetch Failed [\(result)]")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo = repos[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "repo_cell") as? RepoTableViewCell
        if cell === nil {
            cell = RepoTableViewCell(style: .default, reuseIdentifier: "repo_cell")
        }
        cell!.labelName!.text = repo.name
        cell!.labelLanuage!.text = repo.language
        return cell!
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 0 && indexPath.row < repos.count {
            let repo = repos[indexPath.row]
            print("Selected Repo[\(repo.name)]")
            GithubAPI.shared.currentRepo = repo
            self.performSegue(withIdentifier: "repos_list_pulls_list", sender: self)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
