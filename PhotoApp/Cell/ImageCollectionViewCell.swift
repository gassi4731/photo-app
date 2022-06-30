//
//  MemberCollectionViewCell.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.1
        imageView.clipsToBounds = true
    }
    
    func setCellFromMember(member: Member) {
        imageView.downloaded(from: member.mainImageUrl)
    }
    
    func setCellFromMemberImage(image: MemberIntroductionImage) {
        imageView.downloaded(from: image.imageUrl, contentMode: .scaleAspectFill)
    }
}
