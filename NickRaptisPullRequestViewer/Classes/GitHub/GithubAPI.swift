//
//  GithubAPI.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

//https://api.github.com/users/nraptis/repos


enum GithubNotification:String {
    case usersUpdated = "GithubNotification.usersUpdated"
    case reposUpdated = "GithubNotification.reposUpdated"
}


class GithubAPI : NSObject
{
    
    //API object singleton.
    static let shared = GithubAPI()
    
    static var token: String {
        return "ee80354928933bd4361e2894596f73dbd26362a1"
    }
    
    var baseURL:String {
        return "https://api.github.com"
    }
    
    var usersURL: String {
        return "\(baseURL)/users"
    }

    var reposURL: String {
        if let user = currentUser {
            return "\(baseURL)/users/\(user.login)/repos"
        } else {
            return "\(baseURL)/users/nraptis/repos"
        }
    }
    
    var pullsURL: String {
        if let user = currentUser, let repo = currentRepo {
            return "\(baseURL)/repos/\(user.login)/\(repo.name)/pulls"
        } else {
            return "\(baseURL)/repos/nraptis/NickRaptisPullRequestViewer/pulls"
        }
    }
    
    //The currently selected user. (which we will view repositories for)
    var currentUser: GithubUser?
    
    //The currently selected repo. (which we will view pull requests for)
    var currentRepo: GithubRepo?
    
    //The currently selected pull. (which we will view diff for)
    var currentPull: GithubPull?
}


