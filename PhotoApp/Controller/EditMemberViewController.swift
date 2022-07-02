//
//  AddMemberViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class EditMemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isCreate: Bool!
    var member: Member = Member(document: nil)
    var editMemberContents: [SimpleEditContent] = []
    var editImageContents: [MemberIntroductionImage] = []
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
        tableView.register(UINib(nibName: "SimpleEditTableViewCell", bundle: nil), forCellReuseIdentifier: "SimpleEditCell")
        tableView.register(UINib(nibName: "EditImageTableViewCell", bundle: nil), forCellReuseIdentifier: "EditImageCell")
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableView.automaticDimension
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        mainImageView.isUserInteractionEnabled = true
        mainImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedMainImage(_:))))
        
        editMemberContents.append(contentsOf: [
            SimpleEditContent(title: "名前", placeholder: "田中 太郎", value: member.name),
            SimpleEditContent(title: "Twitter", placeholder: "https://twitter.com/username", value: member.sns.twitter),
            SimpleEditContent(title: "Instagram", placeholder: "https://www.facebook.com/username/", value: member.sns.facebook),
            SimpleEditContent(title: "Web", placeholder: "https://sample.com", value: member.sns.web)
        ])
        editImageContents.append(MemberIntroductionImage(document: nil))
        
        if member.mainImageUrl != "" {
            mainImageView.image = UIImage(url: member.mainImageUrl)
            mainImageView.contentMode = .scaleToFill
        }
    }
    
    @IBAction func tappedCancelButton() {
        dismiss(animated: true)
    }
    
    @IBAction func tappedSaveButton() {
        let firstCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! SimpleEditTableViewCell
        if mainImageView.image == UIImage(systemName: "camera.circle") {
            showAlert(title: "人の画像を設定してください")
        } else if firstCell.textField.text == "" {
            showAlert(title: "名前を設定してください")
        } else {
            fetchData()
            
            isCreate ? addMember() : updateMember()
            dismiss(animated: true)
        }
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
    
    func fetchData() {
        let nameTextCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! SimpleEditTableViewCell
        let twitterCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! SimpleEditTableViewCell
        let facebookCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! SimpleEditTableViewCell
        let webCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! SimpleEditTableViewCell
        
        member.name = nameTextCell.textField.text ?? ""
        member.sns.twitter = twitterCell.textField.text ?? ""
        member.sns.facebook = facebookCell.textField.text ?? ""
        member.sns.web = webCell.textField.text ?? ""
        
        var images = editImageContents
        images.removeLast()
        member.images = images
    }
    
    func editImage(introductionImage: MemberIntroductionImage!, index: Int?) {
        editImageContents.removeLast()
        if index != nil {
            editImageContents[index!] = introductionImage
        } else {
            editImageContents.append(introductionImage)
        }
        editImageContents.append(MemberIntroductionImage(document: nil))
        tableView.reloadData()
    }
}

extension EditMemberViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < editMemberContents.count {
            let memberCell = tableView.dequeueReusableCell(withIdentifier: "SimpleEditCell", for: indexPath) as! SimpleEditTableViewCell
            memberCell.setCell(contents: editMemberContents[indexPath.row])
            return memberCell
        } else {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "EditImageCell", for: indexPath) as! EditImageTableViewCell
            let index = indexPath.row - editMemberContents.count
            imageCell.setCell(introImage: editImageContents[index], index: index)
            return imageCell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editMemberContents.count + editImageContents.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
        if indexPath.row >= editMemberContents.count {
            let index = indexPath.row - editMemberContents.count
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "EditIntroductionImageVC") as! EditIntroductionImageViewController
            if index < member.images?.count ?? 0 {
                nextVC.introductionImage = editImageContents[index]
                nextVC.index = index
            }
            let navigationController = UINavigationController(rootViewController: nextVC)
            present(navigationController, animated: true)
        }
    }
}

extension EditMemberViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択されたimageを取得
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage? else {return}
        
        // imageをimageViewに設定
        uploadImage(data: selectedImage.jpegData(compressionQuality: 1)!)
        
        // imagePickerの削除
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Firestore
extension EditMemberViewController {
    func addMember() {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("member")
            .addDocument(data: member.getStringArray()) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
    }
    
    func updateMember() {
        let db = Firestore.firestore()
        db.collection("member").document(member.id)
            .setData(member.getStringArray()) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
    }
    
    func uploadImage(data: Data) {
        var downloadUrl: String!
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("member/\(UUID().uuidString).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = imageRef.putData(data, metadata: metadata) { (metadata, error) in
            guard metadata != nil else {
                // Uh-oh, an error occurred!
                return
            }
            // You can also access to download URL after upload.
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                downloadUrl = downloadURL.absoluteString
                self.member.mainImageUrl = downloadUrl
                self.mainImageView.image = UIImage(url: downloadUrl)
            }
        }
    }
}
