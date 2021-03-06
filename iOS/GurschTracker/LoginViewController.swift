//
//  LoginViewController.swift
//  GurschTracker
//
//  Created by Anton Hägermalm on 2017-10-21.
//  Copyright © 2017 Anton Hägermalm. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, AuthValidation {

	@IBOutlet weak var adminButton: UIButton!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var signinButton: UIButton!
	@IBOutlet weak var signupButton: UIButton!
	@IBOutlet weak var loginTextField: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()
		if CurrentApplicationState.state == ApplicationState.dev {
			adminButton.isEnabled = true
		}
	}

	//Some nice loading is needed here, and fail shit
	@IBAction func signInButtonPressed(_ sender: UIButton) {
		if login() {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let controller = storyboard.instantiateInitialViewController()
			self.present(controller!, animated: true, completion: nil)
		}
	}
	
	//faster login for devs under development
	@IBAction func adminSignIn(_ sender: UIButton) {
		print("admin pressed")
		Auth.auth().signIn(withEmail: "admin@gurschtracker.com", password: "password123") { (user, error) in
		}
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateInitialViewController()
		self.present(controller!, animated: true, completion: nil)
	}

	private func login() -> Bool {
		guard let email = emailTextField.text, isValidEmail(emailTextField.text) else {
			print("invalid email entered")
			return false
		}
		guard let password = passwordTextField.text, isAValidPassword(passwordTextField.text) else {
			print("invalid password entered")
			return false
		}
		var	success = false
		Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
			if error != nil {
				print("faild due to \(error as Any)")
			}
			else {
				success = true
			}
		}
//		return success
		//needs async shit
		return true
	}
}
