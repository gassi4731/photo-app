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
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setMemberInfo()
    }
    
    func setMemberInfo() {
        title = member.name
        nameLabel.text = member.name
        mainImageView.image = UIImage(url: member.mainImageUrl)
        imageCollectionView.reloadData()
    }
}

extension CommunityMemberContainerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if member.images == nil {
            return 0
        } else {
            return member.images!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageWidth = Double(self.view.bounds.width/3 - 17)
        cell.setCellFromMemberImage(image: member.images![indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImageDetailVC") as! ImageDetailViewController
        vc.memberIntroductionImage = member.images![indexPath.row]
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(vc, animated: true, completion: nil)
    }
    
    // アイテムの大きさを設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横方向のスペース調整
        let cellSize:CGFloat = self.view.bounds.width/3 - 17
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    // アイテム表示領域全体の上下左右の余白を設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    // アイテムの上下の余白の最小値を設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
