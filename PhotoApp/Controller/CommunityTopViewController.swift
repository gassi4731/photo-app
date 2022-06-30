//
//  CommunityTopViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/29.
//

import UIKit

class CommunityTopViewController: UIViewController {
    
    var members: [Member] = []
    
    @IBOutlet var memberCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        title = "Sample Community"
        
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        memberCollectionView.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCell")
        
        let layout = UICollectionViewFlowLayout()
        let collectionFrame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        layout.minimumInteritemSpacing = 4 // Cell間の最小サイズ
        layout.minimumLineSpacing = 4 // 行間の最小サイズ
        layout.sectionInset = UIEdgeInsets.zero // Cellのマージン.
        layout.headerReferenceSize = CGSize(width:0,height:0) // セクションのヘッダーサイズ
        layout.itemSize = CGSize(width: (viewWidth - layout.minimumInteritemSpacing - 8) / 3, height: (viewWidth - layout.minimumLineSpacing - 8) / 3) // Cellサイズを適当に決める
        memberCollectionView.frame = collectionFrame
        memberCollectionView.collectionViewLayout = layout
        
        // TODO: delete mock
        let memberIntroductionImage = MemberIntroductionImage(imageUrl: "https://guide.line.me/ja/dogday_01.jpg", title: "犬", discription: "実家では5匹犬を飼ってました")
        let memberSNS = MemberSNS(twitter: "", facebook: "", web: "")
        members.append(contentsOf: [
            Member(name: "田中太郎", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
            Member(name: "山田花子", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
            Member(name: "浅岡千代彦", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
            Member(name: "風岡暢", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
            Member(name: "山中裕一", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
            Member(name: "杉山眞太郎", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
        ])
    }
    
    @IBAction func tappedAddButton() {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "EditMemberVC") as! EditMemberViewController
        nextVC.isCreate = true
        let navigationController = UINavigationController(rootViewController: nextVC)
        present(navigationController, animated: true)
    }
}

extension CommunityTopViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memberCollectionView.dequeueReusableCell(withReuseIdentifier: "MemberCell", for: indexPath) as! MemberCollectionViewCell
        cell.setCell(member: members[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "CommunityMemberVC") as! CommunityMemberViewController
        nextVC.member = members[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
