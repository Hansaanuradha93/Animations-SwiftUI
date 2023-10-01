//
//  PageIntro.swift
//  Animations
//
//  Created by Hansa Wickramanayake on 2023-10-01.
//

import Foundation

/// Page Intro Model
struct PageIntro: Identifiable, Hashable {
    var id: UUID = UUID()
    var introAssetImage: String
    var title: String
    var subTitle: String
    var displaysAction: Bool = false
}

var pageIntros: [PageIntro] = [
    PageIntro(introAssetImage: "Page 1", title: "Connect With\nCreators Easily", subTitle: "Thank you for choosing us, we can save your lovely time."),
    PageIntro(introAssetImage: "Page 2", title: "Get Inspiration\nFrom Creators", subTitle: "Find your favourite creator and get inspired by them."),
    PageIntro(introAssetImage: "Page 3", title: "Let's\nGet Started", subTitle: "To register for an account, kindly enter your details.", displaysAction: true),
]
