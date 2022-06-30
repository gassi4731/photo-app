//
//  MemberCollectionViewCell.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(member: Member) {
        imageView.downloaded(from: member.mainImageUrl)
    }
}
