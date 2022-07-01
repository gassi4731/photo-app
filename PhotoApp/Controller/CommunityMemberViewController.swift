//
//  CommunityMemberViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/29.
//

import UIKit

class CommunityMemberViewController: UIViewController {
    
    var member: Member!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = member.name
        
        let container = self.children[0] as! CommunityMemberContainerViewController
        container.member = member
    }
    
    @IBAction func tappedEditButton() {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "EditMemberVC") as! EditMemberViewController
        nextVC.isCreate = false
        nextVC.member = member
        nextVC.editImageContents = member.images ?? []
        let navigationController = UINavigationController(rootViewController: nextVC)
        present(navigationController, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
