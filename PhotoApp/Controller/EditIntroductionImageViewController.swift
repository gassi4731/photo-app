//
//  AddPhotoViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/07/01.
//

import UIKit
import FirebaseStorage

class EditIntroductionImageViewController: UIViewController {
    
    var introductionImage: MemberIntroductionImage!
    var index: Int!
    var editContents: [SimpleEditContent] = []
    var imagePicker: UIImagePickerController!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var editTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editTableView.delegate = self
        editTableView.dataSource = self
        editTableView.register(UINib(nibName: "SimpleEditTableViewCell", bundle: nil), forCellReuseIdentifier: "SimpleEditCell")
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedImage(_:))))
        
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
    
    @objc func tappedImage(_ sender: UITapGestureRecognizer) {
        present(imagePicker, animated: true)
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

extension EditIntroductionImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択されたimageを取得
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage? else {return}
        
        // imageをimageViewに設定
        uploadImage(data: selectedImage.jpegData(compressionQuality: 1)!)
        
        // imagePickerの削除
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: -FireStorage
extension EditIntroductionImageViewController {
    func uploadImage(data: Data) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("member/introductionImage/\(UUID().uuidString).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = imageRef.putData(data, metadata: metadata) { ( metadata, error ) in
            guard metadata != nil else {
                // Uh-oh, an error occurred!
                return
            }
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                let urlString = downloadURL.absoluteString
                self.introductionImage.imageUrl = urlString
                self.imageView.image = UIImage(url: urlString)
            }
        }
    }
}
