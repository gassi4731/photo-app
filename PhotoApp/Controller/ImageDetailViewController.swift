//
//  ImageDetailViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/07/01.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var memberIntroductionImage: MemberIntroductionImage!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var discriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.downloaded(from: memberIntroductionImage.imageUrl, contentMode: .scaleAspectFill)
        titleLabel.text = memberIntroductionImage.title
        discriptionTextView.text = memberIntroductionImage.discription
    }
    
    @IBAction func tappedCloseButton() {
        dismiss(animated: true)
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
