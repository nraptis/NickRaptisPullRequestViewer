//
//  GithubRepo.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class GithubRepo: NSObject {
    
    var id: Int = -1
    
    var name: String = ""
    var fullName: String = ""
    
    var language: String = ""
    
    var size: Int = 0
    
    var openIssues: Int = 0
    var starGazers: Int = 0
    var watchers: Int = 0
    
    func load(_ info: [String: AnyObject]) {
        if let _id = info["id"] as? Int {
            id = _id
        }
        if let _name = info["name"] as? String {
            name = _name
        }
        if let _fullName = info["full_name"] as? String {
            fullName = _fullName
        }
        if let _language = info["language"] as? String {
            language = _language
        }
        if let _size = info["size"] as? Int {
            size = _size
        }
        if let _openIssues = info["open_issues"] as? Int {
            openIssues = _openIssues
        }
        if let _starGazers = info["stargazers_count"] as? Int {
            starGazers = _starGazers
        }
        if let _watchers = info["watchers"] as? Int {
            watchers = _watchers
        }
    }
    
    
    /*
    Repo Data:
    (
    {
    "archive_url" = "https://api.github.com/repos/ezmobius/acl_system2/{archive_format}{/ref}";
    "assignees_url" = "https://api.github.com/repos/ezmobius/acl_system2/assignees{/user}";
    "blobs_url" = "https://api.github.com/repos/ezmobius/acl_system2/git/blobs{/sha}";
    "branches_url" = "https://api.github.com/repos/ezmobius/acl_system2/branches{/branch}";
    "clone_url" = "https://github.com/ezmobius/acl_system2.git";
    "collaborators_url" = "https://api.github.com/repos/ezmobius/acl_system2/collaborators{/collaborator}";
    "comments_url" = "https://api.github.com/repos/ezmobius/acl_system2/comments{/number}";
    "commits_url" = "https://api.github.com/repos/ezmobius/acl_system2/commits{/sha}";
    "compare_url" = "https://api.github.com/repos/ezmobius/acl_system2/compare/{base}...{head}";
    "contents_url" = "https://api.github.com/repos/ezmobius/acl_system2/contents/{+path}";
    "contributors_url" = "https://api.github.com/repos/ezmobius/acl_system2/contributors";
    "created_at" = "2008-03-25T19:00:13Z";
    "default_branch" = master;
    "deployments_url" = "https://api.github.com/repos/ezmobius/acl_system2/deployments";
    description = "An access control plugin for Rails";
    "downloads_url" = "https://api.github.com/repos/ezmobius/acl_system2/downloads";
    "events_url" = "https://api.github.com/repos/ezmobius/acl_system2/events";
    fork = 0;
    forks = 13;
    "forks_count" = 13;
    "forks_url" = "https://api.github.com/repos/ezmobius/acl_system2/forks";
    
    "git_commits_url" = "https://api.github.com/repos/ezmobius/acl_system2/git/commits{/sha}";
    "git_refs_url" = "https://api.github.com/repos/ezmobius/acl_system2/git/refs{/sha}";
    "git_tags_url" = "https://api.github.com/repos/ezmobius/acl_system2/git/tags{/sha}";
    "git_url" = "git://github.com/ezmobius/acl_system2.git";
    "has_downloads" = 1;
    "has_issues" = 1;
    "has_pages" = 0;
    "has_projects" = 1;
    "has_wiki" = 1;
    homepage = "";
    "hooks_url" = "https://api.github.com/repos/ezmobius/acl_system2/hooks";
    "html_url" = "https://github.com/ezmobius/acl_system2";
    
    
    "issue_comment_url" = "https://api.github.com/repos/ezmobius/acl_system2/issues/comments{/number}";
    "issue_events_url" = "https://api.github.com/repos/ezmobius/acl_system2/issues/events{/number}";
    "issues_url" = "https://api.github.com/repos/ezmobius/acl_system2/issues{/number}";
    "keys_url" = "https://api.github.com/repos/ezmobius/acl_system2/keys{/key_id}";
    "labels_url" = "https://api.github.com/repos/ezmobius/acl_system2/labels{/name}";
    
    
    "languages_url" = "https://api.github.com/repos/ezmobius/acl_system2/languages";
    "merges_url" = "https://api.github.com/repos/ezmobius/acl_system2/merges";
    "milestones_url" = "https://api.github.com/repos/ezmobius/acl_system2/milestones{/number}";
    "mirror_url" = "<null>";
    
    "notifications_url" = "https://api.github.com/repos/ezmobius/acl_system2/notifications{?since,all,participating}";
    
    "open_issues_count" = 1;
    owner =         {
    "avatar_url" = "https://avatars3.githubusercontent.com/u/5?v=3";
    "events_url" = "https://api.github.com/users/ezmobius/events{/privacy}";
    "followers_url" = "https://api.github.com/users/ezmobius/followers";
    "following_url" = "https://api.github.com/users/ezmobius/following{/other_user}";
    "gists_url" = "https://api.github.com/users/ezmobius/gists{/gist_id}";
    "gravatar_id" = "";
    "html_url" = "https://github.com/ezmobius";
    id = 5;
    login = ezmobius;
    "organizations_url" = "https://api.github.com/users/ezmobius/orgs";
    "received_events_url" = "https://api.github.com/users/ezmobius/received_events";
    "repos_url" = "https://api.github.com/users/ezmobius/repos";
    "site_admin" = 0;
    "starred_url" = "https://api.github.com/users/ezmobius/starred{/owner}{/repo}";
    "subscriptions_url" = "https://api.github.com/users/ezmobius/subscriptions";
    type = User;
    url = "https://api.github.com/users/ezmobius";
    };
    private = 0;
    "pulls_url" = "https://api.github.com/repos/ezmobius/acl_system2/pulls{/number}";
    "pushed_at" = "2008-10-13T21:03:58Z";
    "releases_url" = "https://api.github.com/repos/ezmobius/acl_system2/releases{/id}";
    
    
    
    "ssh_url" = "git@github.com:ezmobius/acl_system2.git";
    
    "stargazers_url" = "https://api.github.com/repos/ezmobius/acl_system2/stargazers";
    "statuses_url" = "https://api.github.com/repos/ezmobius/acl_system2/statuses/{sha}";
    "subscribers_url" = "https://api.github.com/repos/ezmobius/acl_system2/subscribers";
    "subscription_url" = "https://api.github.com/repos/ezmobius/acl_system2/subscription";
    "svn_url" = "https://github.com/ezmobius/acl_system2";
    "tags_url" = "https://api.github.com/repos/ezmobius/acl_system2/tags";
    "teams_url" = "https://api.github.com/repos/ezmobius/acl_system2/teams";
    "trees_url" = "https://api.github.com/repos/ezmobius/acl_system2/git/trees{/sha}";
    "updated_at" = "2017-01-18T23:54:52Z";
    url = "https://api.github.com/repos/ezmobius/acl_system2";
    
    "watchers_count" = 60;
    */
    
}
