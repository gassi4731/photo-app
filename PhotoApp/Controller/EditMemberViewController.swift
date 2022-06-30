//
//  AddMemberViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import UIKit

struct EditMemberContent {
    let title: String
    let placeholder: String
    var value: String
}

class EditMemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isCreate: Bool!
    var editMemberContents: [EditMemberContent] = []
    var imagePicker: UIImagePickerController!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if isCreate {
            title = "メンバーを追加"
        } else {
            title = "編集"
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EditMemberTableViewCell", bundle: nil), forCellReuseIdentifier: "EditMemberCell")
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        mainImageView.isUserInteractionEnabled = true
        mainImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedMainImage(_:))))
        
        editMemberContents.append(contentsOf: [
            EditMemberContent(title: "名前", placeholder: "田中 太郎", value: ""),
            EditMemberContent(title: "Twitter", placeholder: "https://twitter.com/username", value: ""),
            EditMemberContent(title: "Instagram", placeholder: "https://www.facebook.com/username/", value: ""),
            EditMemberContent(title: "Web", placeholder: "https://sample.com", value: "")
        ])
    }
    
    @IBAction func tappedCancelButton() {
        dismiss(animated: true)
    }
    
    @IBAction func tappedSaveButton() {
        // TODO: saveの動作を追加
    }
    
    @objc func tappedMainImage(_ sender: UITapGestureRecognizer) {
        present(imagePicker, animated: true)
    }
}

extension EditMemberViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditMemberCell", for: indexPath) as! EditMemberTableViewCell
        cell.setCell(contents: editMemberContents[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editMemberContents.count
    }
}

extension EditMemberViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択されたimageを取得
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage? else {return}
        
        // imageをimageViewに設定
        mainImageView.image = selectedImage
        
        // imagePickerの削除
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
