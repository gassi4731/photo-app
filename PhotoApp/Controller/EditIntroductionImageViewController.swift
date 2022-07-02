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
        editTableView.delegate = self
        editTableView.dataSource = self
        editTableView.register(UINib(nibName: "SimpleEditTableViewCell", bundle: nil), forCellReuseIdentifier: "SimpleEditCell")
        
        if introductionImage != nil {
            imageView.image = UIImage(url: introductionImage.imageUrl)
            editContents.append(contentsOf: [
                SimpleEditContent(title: "タイトル", placeholder: "例: 犬", value: introductionImage.title),
                SimpleEditContent(title: "説明", placeholder: "例: 実家では犬を5匹飼ってました！", value: introductionImage.discription),
            ])
        } else {
            editContents.append(contentsOf: [
                SimpleEditContent(title: "タイトル", placeholder: "例: 犬", value: ""),
                SimpleEditContent(title: "説明", placeholder: "例: 実家では犬を5匹飼ってました！", value: ""),
            ])
        }
    }
}

extension EditIntroductionImageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editTableView.dequeueReusableCell(withIdentifier: "SimpleEditCell") as! SimpleEditTableViewCell
        cell.setCell(contents: editContents[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
}
