//
//  ServerSelectionServerSelectionViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class ServerSelectionViewController: UIViewController {
    //MARK: - Properties
    var eventHandler: ServerSelectionEventHandling!
    //MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var serverTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
    }
    
    //MARK: - Actions
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let address = serverTextField.text {
            eventHandler.handleServerAddress(address: address)
        }
    }
    
    //MARK: - Private -
    private var tapRecognizer: HideKeyboardRecognizer?
    
    //MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        serverTextField.delegate = self
        tapRecognizer = HideKeyboardRecognizer(withView: view)
        configureNavigationBar()
    }
    
    private func localizeViews() {
        headerLabel.text = R.string.localizable.welcome()
        descriptionLabel.text = R.string.localizable.description()
        hintLabel.text = R.string.localizable.serverFieldHint()
        nextButton.setTitle(R.string.localizable.nextButtonTitle(), for: .normal)
    }
    
    private func configureNavigationBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.barTintColor = .white
        navBar.clearShadow()
        let backButtonInsets = UIEdgeInsets(top: 13, left: 20, bottom: 0, right: 0)
        let backButtonImage = R.image.back()?
            .withRenderingMode(.alwaysOriginal)
            .withAlignmentRectInsets(backButtonInsets)
        navBar.backIndicatorImage = backButtonImage
        navBar.backIndicatorTransitionMaskImage = backButtonImage
    }
    
}

//MARK: - ServerSelectionViewing
extension ServerSelectionViewController: ServerSelectionViewing {
}

//MARK: - UITextFieldDelegate
extension ServerSelectionViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let resultString = NSString(string: currentText).replacingCharacters(in: range, with: string)
        nextButton.isEnabled = !resultString.isEmpty
        return true
    }
    
}
