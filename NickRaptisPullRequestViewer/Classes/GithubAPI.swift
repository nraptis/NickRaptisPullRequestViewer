//
//  GithubAPI.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

//https://api.github.com/users/nraptis/repos

class GithubAPI
{
    static var baseURL:String {
        return "https://api.github.com/"
    }

    var currentUser: String {
        return ""
    }
    
    var currentRepo: String {
        return ""
    }
    
    var currentPullRequest: String {
        return ""
    }
    
}


