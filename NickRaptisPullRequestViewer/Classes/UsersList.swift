//
//  UsersList.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class UsersList: UIViewController, WebFetcherDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    internal var _usersFetcher: WebFetcher?
    var usersFetcher: WebFetcher {
        
        if _usersFetcher === nil {
            _usersFetcher = WebFetcher()
            _usersFetcher!.delegate = self
        }
        return _usersFetcher!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 1.0, green: 0.25, blue: 0.25, alpha: 0.6)
        
        
        usersFetcher.fetch(GithubAPI.usersURL)
        
        //GithubAPI : NSObject
        //{
        //static let shared
            
        //usersFetcher.fetch(  )
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchDidSucceed(fetcher: WebFetcher, result: WebResult) {
        
        print("Users - Fetch Succeeded [\(result)]")
        
        if let data = FileUtils.parseJSON(usersFetcher.data) {
            
            print("User Data:\n\(data)")
            
            if let userArray = data as? [[String: AnyObject]] {
                
                for userInfo in userArray {
                    
                    print("===============")
                    print(userInfo)
                    
                    /*
                    "avatar_url" = "https://avatars3.githubusercontent.com/u/1?v=3";
                    "events_url" = "https://api.github.com/users/mojombo/events{/privacy}";
                    "followers_url" = "https://api.github.com/users/mojombo/followers";
                    "following_url" = "https://api.github.com/users/mojombo/following{/other_user}";
                    "gists_url" = "https://api.github.com/users/mojombo/gists{/gist_id}";
                    "gravatar_id" = "";
                    "html_url" = "https://github.com/mojombo";
                    id = 1;
                    login = mojombo;
                    "organizations_url" = "https://api.github.com/users/mojombo/orgs";
                    "received_events_url" = "https://api.github.com/users/mojombo/received_events";
                    "repos_url" = "https://api.github.com/users/mojombo/repos";
                    "site_admin" = 0;
                    "starred_url" = "https://api.github.com/users/mojombo/starred{/owner}{/repo}";
                    "subscriptions_url" = "https://api.github.com/users/mojombo/subscriptions";
                    type = User;
                    url = "https://api.github.com/users/mojombo";
                    */
                    
                    
                }
                
            }
            
            
            
        } else {
            print("Error Out")
            
        }
    }
    
    func fetchDidFail(fetcher: WebFetcher, result: WebResult) {
        print("Users - Fetch Failed [\(result)]")
        
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
