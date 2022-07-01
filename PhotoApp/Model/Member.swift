//
//  Member.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import Foundation
import FirebaseFirestore

struct Member {
    let name: String
    let mainImageUrl: String
    let images: [MemberIntroductionImage]?
    let sns: MemberSNS
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
}

struct MemberIntroductionImage {
    let imageUrl: String
    let title: String
    let discription: String
    
    init(document: [String: Any]?) {
        if document == nil {
            imageUrl = ""; title = ""; discription = "";
        } else {
            imageUrl = document!["imageUrl"] as! String
            title = document!["title"] as! String
            discription = document!["discription"] as! String
        }
    }
}

struct MemberSNS {
    let twitter: String
    let facebook: String
    let web: String

    init(document: [String: Any]?) {
        if document == nil {
            twitter = ""; facebook = ""; web = "";
        } else {
            twitter = document!["twitter"] as! String
            facebook = document!["facebook"] as! String
            web = document!["web"] as! String
        }
    }
}
