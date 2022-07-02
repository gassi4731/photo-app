//
//  AddPhotoViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/07/01.
//

import UIKit

class EditIntroductionImageViewController: UIViewController {
    
    var introductionImage: MemberIntroductionImage!
    var index: Int!
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
                SimpleEditContent(title: "タイトル", placeholder: "犬", value: introductionImage.title),
                SimpleEditContent(title: "説明", placeholder: "実家では犬を5匹飼ってました！", value: introductionImage.discription),
            ])
        } else {
            introductionImage = MemberIntroductionImage(document: nil)
            editContents.append(contentsOf: [
                SimpleEditContent(title: "タイトル", placeholder: "犬", value: ""),
                SimpleEditContent(title: "説明", placeholder: "実家では犬を5匹飼ってました！", value: ""),
            ])
        }
    }
    
    @IBAction func tappedCancelButton() {
        dismiss(animated: true)
    }
    
    @IBAction func tappedSaveButton() {
        fetchTextField()
        
        let preNC = self.presentingViewController as! UINavigationController
        let preVC = preNC.viewControllers[preNC.viewControllers.count - 1]  as! EditMemberViewController
        preVC.editImage(introductionImage: introductionImage, index: index)
        dismiss(animated: true)
    }
    
    func fetchTextField() {
        let titleTextCell = editTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! SimpleEditTableViewCell
        let descriptionCell = editTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! SimpleEditTableViewCell
        
        introductionImage.title = titleTextCell.textField.text ?? ""
        introductionImage.discription = descriptionCell.textField.text ?? ""
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
