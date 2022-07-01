//
//  WelcomeViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/29.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // TODO: 一時的にTopViewに遷移するように変更
        UserDefaults.standard.set("rHalKOlryYBgHMwyaXr3", forKey: "groupId")
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "CommunityTopVC") as! CommunityTopViewController
        let nav = UINavigationController(rootViewController: nextVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
