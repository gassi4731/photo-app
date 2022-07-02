//
//  CommunityMemberViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/29.
//

import UIKit
import FirebaseFirestore

class CommunityMemberViewController: UIViewController {
    
    var member: Member!
    var groupId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        groupId = UserDefaults.standard.string(forKey: "groupId")
        fetchData()
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
}

// MARK: -Firebase
extension CommunityMemberViewController {
    func fetchData() {
        let db = Firestore.firestore()
        db.collection("group").document(groupId).collection("member").document(member.id)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                self.member.updateFromArray(data: data)
                self.navigationItem.title = self.member.name
                
                let container = self.children[0] as! CommunityMemberContainerViewController
                container.member = self.member
                container.setMemberInfo()
            }
    }
}
