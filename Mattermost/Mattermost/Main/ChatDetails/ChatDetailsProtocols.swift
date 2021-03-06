//
//  ChatDetailsChatDetailsProtocols.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 01/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol PostsService {
    func requestPosts(offset:String, completion: @escaping PostsCompletion) -> CancellableRequest?
    func requestMorePosts(afterPost postId:String, completion: @escaping PostsCompletion) -> CancellableRequest?
    func sendPost(withMessage message:String, channelId:String,
                  replyId:String?, completion: @escaping PostCompletion) -> String
    func updateLastViewedDate(atChannel channelId: String)
}

protocol ChatDetailsConfigurator: class {
}

protocol ChatDetailsInteracting: class {
    func getMorePosts(completion: @escaping PostsCompletion)
    func refresh(completion: @escaping PostsCompletion)
    func sendMessage(message:String, replyId: String?, completion:@escaping PostCompletion) -> String
    func updateLastPost(with post:Post)
    var channel:Channel { get }
}

protocol ChatDetailsPresenting: class {
    func addNew(post:Post)
}

protocol MessageCellViewing {
    func configure(withRepresentationModel model: PostRepresentationModel)
}

protocol ChatDetailsViewing: AlertShowable {
    func refreshData(withPosts posts: [PostRepresentationModel])
    func addMorePosts(_ posts: [PostRepresentationModel])
    func insert(post:PostRepresentationModel)
    func update(post: PostRepresentationModel)
    func showError(forPostWithPlaceholderId id:String)
    func showActivityIndicator()
    func hideActivityIndicator()
    func showReplyPost(_ post:PostRepresentationModel)
    func closeReply()
}

protocol ChatDetailsEventHandling: class {
    func viewIsReady()
    func handleBack()
    func handlePagination()
    func refresh()
    func handleSendMessage(_ message:String)
    func handleRetry(forPlaceholderPost post: PostRepresentationModel)
    func handleAttachPressed()
    func handleReply(post: PostRepresentationModel)
    func handleCloseReply()
}

protocol ChatDetailsCoordinator: class {
    func handleBack()
}
