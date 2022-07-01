//
//  AddPhotoViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/07/01.
//

import UIKit

class EditIntroductionImageViewController: UIViewController {
    
    var introductionImage: MemberIntroductionImage!
    var editContents: [SimpleEditContent] = []
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var editTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editTableView.register(UINib(nibName: "SimpleEditTableViewCell", bundle: nil), forCellReuseIdentifier: "SimpleEditCell")
        
        if introductionImage != nil {
            imageView.image = UIImage(url: introductionImage.imageUrl)
        }
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
