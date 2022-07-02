//
//  EditImageTableViewCell.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/07/01.
//

import UIKit

class EditImageTableViewCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var introImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(introImage: MemberIntroductionImage?, index: Int) {
        if introImage?.imageUrl == nil || introImage?.imageUrl == "" {
            label.text = "写真追加"
            introImageView.image = UIImage(systemName: "plus")
        } else {
            label.text = introImage!.title
            introImageView.image = UIImage(url: introImage!.imageUrl)
        }
    }
}
