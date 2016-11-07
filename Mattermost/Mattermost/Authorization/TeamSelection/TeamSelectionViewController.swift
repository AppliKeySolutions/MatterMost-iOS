//
//  TeamSelectionTeamSelectionViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class TeamSelectionViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: TeamSelectionEventHandling!
  
  	//MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        configureInterface()
	}

	//MARK: - Private -

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
    }
    
    private func localizeViews() {
    }

}

extension TeamSelectionViewController: TeamSelectionViewing {
}
