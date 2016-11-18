//
//  ChatsChatsViewController.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 16/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class ChatsViewController: UIViewController {
	
	//MARK: - Properties
    
  	var eventHandler: ChatsEventHandling!
    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate var chats = [ChatRepresentationModel]()

  	//MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.icMenu(), style: .done,
                                                           target: self, action: #selector(openMenuPressed(_:)))
        configureInterface()
        eventHandler.viewIsReady()
    }
    
    //MARK: -
    
    func openMenuPressed(_ sender:AnyObject) {
        eventHandler.openMenu()
    }

	//MARK: - Private -

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        tableView.register(R.nib.singleChatCell)
    }
    
    private func localizeViews() {
    }

}

extension ChatsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatViewModel = chats[indexPath.row]
        if chatViewModel.isDirectChat {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.singleChatCell, for: indexPath)!
            configure(cell: cell, forRepresentationModel: chatViewModel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func configure(cell:SingleChatCell, forRepresentationModel model:ChatRepresentationModel) {
        cell.userName = model.chatName
        cell.deliveryTime = model.deliveryTime
        cell.isUnread = model.isUnread
        cell.lastMessage = model.lastMessage
        cell.onlineStatusColor = model.onlineStatusColor
        if let avatarUrl = model.avatarUrl?.first {
            cell.avatarImageView.setImage(withUrl: avatarUrl)
        } else {
            cell.avatarImageView.image = nil
        }
    }
    
}

extension ChatsViewController: ChatsViewing {
    
    func updateView(withRepresentationModel chatsRepresentation: [ChatRepresentationModel]) {
        chats = chatsRepresentation
        tableView.reloadData()
    }
    
}
