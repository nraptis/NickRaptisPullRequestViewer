//
//  UsersList.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class UsersList: UIViewController, WebFetcherDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [GithubUser]()
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        usersFetcher.fetch(GithubAPI.shared.usersURL)
    }
    
    func fetchDidSucceed(fetcher: WebFetcher, result: WebResult) {
        
        print("Users - Fetch Succeeded [\(result)]")
        
        if let data = FileUtils.parseJSON(usersFetcher.data) {
            if let userArray = data as? [[String: AnyObject]] {
                
                users.removeAll()
                
                let nraptis = GithubUser()
                nraptis.login = "nraptis"
                nraptis.id = 4358345
                users.append(nraptis)
                
                for userInfo in userArray {
                    
                    let newUser = GithubUser()
                    newUser.load(userInfo)
                    
                    //Valid user has a login.
                    if newUser.login.characters.count > 0 {
                        print("Appending User (\(newUser.login) id:\(newUser.id))")
                        users.append(newUser)
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
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "user_cell")
        if cell === nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "user_cell")
        }
        cell!.textLabel!.text = user.login
        return cell!
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected Index Section[\(indexPath.section)] Row[\(indexPath.row)]")
        
        if indexPath.row >= 0 && indexPath.row < users.count {
            let user = users[indexPath.row]
            
            print("Selected User[\(user.login)]")
            GithubAPI.shared.currentUser = user
            
            for i:Int in 0..<users.count {
                let ip = IndexPath(row: i, section: 0)
                tableView.deselectRow(at: ip, animated: true)
            }
            
            self.performSegue(withIdentifier: "users_list_repos_list", sender: self)
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
