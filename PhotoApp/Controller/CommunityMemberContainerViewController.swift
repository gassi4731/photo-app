//
//  CommunityMemberContainerViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import UIKit

class CommunityMemberContainerViewController: UIViewController {
    
    var member: Member!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var mainImageVIew: UIImageView!
    @IBOutlet var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setMemberInfo()
    }
    
    func setMemberInfo() {
        title = member.name
        nameLabel.text = member.name
        mainImageVIew.downloaded(from: member.mainImageUrl)
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
