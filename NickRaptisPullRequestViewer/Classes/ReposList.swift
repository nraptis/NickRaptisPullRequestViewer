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
        
        print("Repos - Fetch Succeeded [\(result)]")
        
        if let data = FileUtils.parseJSON(reposFetcher.data) {
            
            print("Repo Data:\n\(data)")
            
            if let reposArray = data as? [[String: AnyObject]] {
                
                repos.removeAll()
                
                for repoInfo in reposArray {
                    let repo = GithubRepo()
                    repo.load(repoInfo)
                    
                    if repo.name.characters.count > 0 {
                        repos.append(repo)
                    }
                }
            } else {
                print("Error Out")
            }
        } else {
            print("Error Out")
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "repo_cell")
        if cell === nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "repo_cell")
        }
        cell!.textLabel!.text = "REPO"
        return cell!
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        print("Selected Index Section[\(indexPath.section)] Row[\(indexPath.row)]")
        
        if indexPath.row >= 0 && indexPath.row < repos.count {
            let repo = repos[indexPath.row]
            
            //print("Selected Repo[\(user.login)]")
            GithubAPI.shared.currentRepo = repo
            
            //tableView.deselectRow(at: indexPath, animated: true)
            
            //self.performSegue(withIdentifier: "users_list_repos_list", sender: self)
            
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
