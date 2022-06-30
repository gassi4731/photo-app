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
    var member: Member = Member(name: "", mainImageUrl: "", images: nil, sns: MemberSNS(twitter: nil, facebook: nil, web: nil), id: "")
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
            EditMemberContent(title: "名前", placeholder: "田中 太郎", value: member.name),
            EditMemberContent(title: "Twitter", placeholder: "https://twitter.com/username", value: member.sns.twitter),
            EditMemberContent(title: "Instagram", placeholder: "https://www.facebook.com/username/", value: ""),
            EditMemberContent(title: "Web", placeholder: "https://sample.com", value: "")
        ])
        
        if member.mainImageUrl != "" {
            mainImageView.downloaded(from: member.mainImageUrl, contentMode: .scaleAspectFill)
        }
    }
    
    @IBAction func tappedCancelButton() {
        dismiss(animated: true)
    }
    
    @IBAction func tappedSaveButton() {
        let firstCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EditMemberTableViewCell
        if mainImageView.image == UIImage(systemName: "camera.circle") {
            showAlert(title: "人の画像を設定してください")
        } else if firstCell.textField.text == "" {
            showAlert(title: "名前を設定してください")
        }
        // TODO: saveの動作を追加
    }
    
    @objc func tappedMainImage(_ sender: UITapGestureRecognizer) {
        present(imagePicker, animated: true)
    }
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
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
