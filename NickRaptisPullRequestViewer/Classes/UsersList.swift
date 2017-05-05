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
        
        usersFetcher.fetch(GithubAPI.usersURL)
    }
    
    func fetchDidSucceed(fetcher: WebFetcher, result: WebResult) {
        
        print("Users - Fetch Succeeded [\(result)]")
        
        if let data = FileUtils.parseJSON(usersFetcher.data) {
            
            print("User Data:\n\(data)")
            
            if let userArray = data as? [[String: AnyObject]] {
                
                users.removeAll()
                
                for userInfo in userArray {
                    
                    let newUser = GithubUser()
                    if let _id = userInfo["id"] as? Int {
                        newUser.id = _id
                    }
                    
                    if let _login = userInfo["login"] as? String {
                        newUser.login = _login
                    }
                    
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if indexPath.row >= 0 && indexPath.row < users.count {
            let user = users[indexPath.row]
            
            print("Selected User[\(user.login)]")
            GithubAPI.shared.currentUser = user
            
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
