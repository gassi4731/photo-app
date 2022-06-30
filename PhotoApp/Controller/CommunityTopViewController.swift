//
//  CommunityTopViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/29.
//

import UIKit

class CommunityTopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Sample Community"
    }

    @IBAction func tappedAddButton() {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "EditMemberVC") as! EditMemberViewController
        nextVC.isCreate = true
        let navigationController = UINavigationController(rootViewController: nextVC)
        present(navigationController, animated: true)
    }
}
