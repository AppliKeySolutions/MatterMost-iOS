//
//  ChatsTarget.swift
//  Mattermost
//
//  Created by iOS_Developer on 24.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result
import Unbox

struct FirstPostsTarget: MattermostTarget, ResponseMapping {
    
    //MARK: - Properties
    let teamId: String
    let channelId: String
    let offset: String
    let limit: String
    
    //MARK: - MattermostTarget -
    
    var path:String {
        return "/teams/" + teamId + "/channels/" + channelId + "/posts/page/" + offset + "/" + limit
    }
    
    func map(_ response: Moya.Response) throws -> [Post] {
        if let json = try response.mapJSON() as? UnboxableDictionary,
            let postsJson = json["posts"] as? UnboxableDictionary,
            let orderArray = json["order"] as? [String] {
            let orderSet = Set<String>(orderArray)
            var posts: [Post] = []
            for key in postsJson.keys {
                if let post = try? unbox(dictionary: postsJson, atKey: key) as Post,
                   orderSet.contains(post.id) {
                    if let rootId = post.parentId, let replyedPost = try? unbox(dictionary: postsJson, atKey: rootId) as Post {
                        post.replyedMessage = replyedPost.message
                    }
                    posts.append(post)
                }
            }
            return posts
        } else {
            throw UnboxError(message: "Invalid json")
        }
    }
}

struct NextPostsTarget: MattermostTarget, ResponseMapping {
    
    //MARK: - Properties
    let teamId: String
    let channelId: String
    let postId: String
    let offset: String
    let limit: String
    
    //MARK: - MattermostTarget -
    
    var path:String {
        return "/teams/\(teamId)/channels/\(channelId)/posts/\(postId)/before/\(offset)/\(limit)"
    }
    
    func map(_ response: Moya.Response) throws -> [Post] {
        if let json = try response.mapJSON() as? UnboxableDictionary {
            guard let postsJson = json["posts"] as? UnboxableDictionary,
                  let orderArray = json["order"] as? [String]
                else { return [] }
            let orderSet = Set<String>(orderArray)
            var posts: [Post] = []
            for key in postsJson.keys {
                if let post = try? unbox(dictionary: postsJson, atKey: key) as Post,
                    orderSet.contains(post.id) {
                    if let rootId = post.parentId, let replyedPost = try? unbox(dictionary: postsJson, atKey: rootId) as Post {
                        post.replyedMessage = replyedPost.message
                    }
                    posts.append(post)
                }
            }
            return posts
        } else {
            throw UnboxError(message: "Invalid json")
        }
    }
}
