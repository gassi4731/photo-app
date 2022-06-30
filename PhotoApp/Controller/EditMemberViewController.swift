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
    
    @IBOutlet var tableView: UITableView!

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
        
        editMemberContents.append(EditMemberContent(title: "名前", placeholder: "田中 太郎", value: ""))
        editMemberContents.append(EditMemberContent(title: "Twitter", placeholder: "https://twitter.com/username", value: ""))
        editMemberContents.append(EditMemberContent(title: "Instagram", placeholder: "https://www.facebook.com/username/", value: ""))
        editMemberContents.append(EditMemberContent(title: "Web", placeholder: "https://sample.com", value: ""))
    }
    
    @IBAction func tappedCancelButton() {
        dismiss(animated: true)
    }
    
    @IBAction func tappedSaveButton() {
        // TODO: saveの動作を追加
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
