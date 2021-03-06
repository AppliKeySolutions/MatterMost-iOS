//
//  SettingsSettingsPresenter.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 11/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class SettingsPresenter {
    
	//MARK: - Properties
    weak var view: SettingsViewing!
    var interactor: SettingsInteracting!
    fileprivate var oldUnreadValue:Bool = false
	
	//MARK: - Init
    
    required init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: SettingsCoordinator
}

extension SettingsPresenter: SettingsConfigurator {
}

extension SettingsPresenter: SettingsPresenting {
}

extension SettingsPresenter: SettingsEventHandling {
    
    func viewIsReady() {
        oldUnreadValue = interactor.hideUnreadController
        view.setUnreadSwitcher(withValue: !interactor.hideUnreadController)
    }
    
    func handleSwitcherValueChanged(_ value: Bool) {
        interactor.hideUnreadController = !value
    }
    
    func viewWillDissapear() {
        let newUnreadValue = interactor.hideUnreadController
        if oldUnreadValue != newUnreadValue {
            coordinator.checkTabBarControllers()
        }
    }
    
    func handleEditProfile() {
        print("edit profile")
    }
    
    func handleLogout() {
        SessionManager.shared.clearCurrentSession()
        coordinator.showAuthorization()
    }
}
