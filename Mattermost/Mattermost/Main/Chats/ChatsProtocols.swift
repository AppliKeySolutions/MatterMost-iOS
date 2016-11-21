//
//  ChatsChatsProtocols.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 16/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

enum ChatsMode : Int {
    case unread
    case favourites
    case publicChats
    case privateChats
    case direct
}

protocol ChatsConfigurator: class {
}

protocol ChatsInteracting: class {
}

protocol ChatsPresenting: class {
}

protocol ChatsViewing: class {
}

protocol ChatsEventHandling: class {
    func openMenu()
}

protocol ChatsCoordinator: class {
    func openMenu()
}