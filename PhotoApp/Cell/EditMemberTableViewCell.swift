//
//  EditMemberTableViewCell.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import UIKit

class EditMemberTableViewCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(contents: EditMemberContent) {
        label.text = contents.title
        textField.text = contents.value
        textField.placeholder = "例: \(contents.placeholder)"
    }
}
