//
//  UIImageView+.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import UIKit

extension UIImage {
    public convenience init(url: String){
        guard let urlPath = URL(string: url) else { print(url); self.init(); return }
        do {
            let data = try Data(contentsOf: urlPath)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
