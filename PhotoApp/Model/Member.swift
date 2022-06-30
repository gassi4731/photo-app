//
//  Member.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/30.
//

import Foundation

struct Member {
    let name: String
    let mainImageUrl: String
    let images: [MemberIntroductionImage]
    let sns: MemberSNS
}

struct MemberIntroductionImage {
    let imageUrl: String
    let title: String
    let discription: String
}

struct MemberSNS {
    let twitter: String
    let facebook: String
    let web: String
}
