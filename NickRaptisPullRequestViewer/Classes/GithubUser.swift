//
//  GithubUser.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class GithubUser: NSObject {
    
    var id: Int = -1
    var login: String = ""
    
    func load(_ info: [String: AnyObject]) {
        if let _id = info["id"] as? Int {
            id = _id
        }
        if let _login = info["login"] as? String {
            login = _login
        }
    }
    
}
