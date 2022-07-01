//
//  Member.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import Foundation
import FirebaseFirestore

struct Member {
    var name: String
    var mainImageUrl: String
    var images: [MemberIntroductionImage]?
    var sns: MemberSNS
    let id: String
    
    init(document: QueryDocumentSnapshot?) {
        if document == nil {
            name = ""; mainImageUrl = ""; images = nil; id = ""; sns = MemberSNS(document: nil);
        } else {
            name = document!["name"] as! String
            mainImageUrl = document!["mainImageUrl"] as? String ?? ""
            sns = MemberSNS(document: document!["sns"] as? [String: Any])
            id = document!.documentID
            
            let imageDocuments = document!["images"] as! [[String: Any]]
            images = imageDocuments.map{ MemberIntroductionImage(document: $0) }
        }
    }
    
    func getStringArray() -> [String: Any] {
        var arrayImages: [[String: String]] = []
        
        if images != nil {
            arrayImages = images!.map{ $0.getStringArray() }
        }
        
        let data = [
            "name": name,
            "mainImageUrl": mainImageUrl,
            "images": arrayImages,
            "sns": sns.getStringArray(),
        ] as [String : Any]
        return data
    }
}

struct MemberIntroductionImage {
    var imageUrl: String
    var title: String
    var discription: String
    
    init(document: [String: Any]?) {
        if document == nil {
            imageUrl = ""; title = ""; discription = "";
        } else {
            imageUrl = document!["imageUrl"] as! String
            title = document!["title"] as! String
            discription = document!["discription"] as! String
        }
    }
    
    func getStringArray() -> [String: String] {
        let data = [
            "imageUrl": imageUrl,
            "title": title,
            "discription": discription,
        ]
        return data
    }
}

struct MemberSNS {
    var twitter: String
    var facebook: String
    var web: String

    init(document: [String: Any]?) {
        if document == nil {
            twitter = ""; facebook = ""; web = "";
        } else {
            twitter = document!["twitter"] as! String
            facebook = document!["facebook"] as! String
            web = document!["web"] as! String
        }
    }
    
    func getStringArray() -> [String: String] {
        let data = [
            "twitter": twitter,
            "facebook": facebook,
            "web": web,
        ]
        return data
    }
}
