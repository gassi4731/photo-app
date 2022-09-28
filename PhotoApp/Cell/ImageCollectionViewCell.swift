//
//  MemberCollectionViewCell.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    var imageWidth: Double!
    
    @IBOutlet var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let rect:CGRect = CGRect(x:0, y:0, width:150, height:150)
        imageView.frame = rect
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.1
        imageView.clipsToBounds = true
    }
    
    func setCellFromMember(member: Member) {
        let image = UIImage(url: member.mainImageUrl)
        imageView.image = resize(image: image, width: imageWidth)
    }
    
    func setCellFromMemberImage(image: MemberIntroductionImage) {
        let image = UIImage(url: image.imageUrl)
        imageView.image = resize(image: image, width: imageWidth)
    }
    
    func resize(image: UIImage, width: Double) -> UIImage {
        // オリジナル画像のサイズからアスペクト比を計算
        let aspectScale = image.size.height / image.size.width
        
        // widthからアスペクト比を元にリサイズ後のサイズを取得
        let resizedSize = CGSize(width: width, height: width * Double(aspectScale))
        
        // リサイズ後のUIImageを生成して返却
        UIGraphicsBeginImageContext(resizedSize)
        image.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
}
