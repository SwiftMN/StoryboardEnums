//
//  LoginViewController.swift
//  StoryboardFun
//
//  Created by Adam Ahrens on 3/22/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Change Color UIColor.

  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    
    // Checking segue identifier segue = LoginViewController
  }

  @IBAction func magicPressed(_ sender: UIButton) {

    // Storyboard Extensions Class.self
    let vc = storyboard?.instantiateViewController(ofType: FirstViewController.self)

    // StronglyTyped UIViewController
    let second = Storyboards.Login.instantiateSecond()
    second.stupidThingToSet = ""
    navigationController?.pushViewController(second, animated: true)

    // Improved perform Class.Segue.
    perform(segue: LoginViewController.Segue.loginToFirst)

    // What's going to happen here?
    // BOOM
    perform(segue: FirstViewController.Segue.firstToThird)
  }
}
