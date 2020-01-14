//
//  IntroData.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/13/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import Foundation

class IntroData {
    var introImage: String = ""
    var introTitle: String = ""
    var introDetails: String = ""
    
    init(introImage: String, introTitle: String, introDetails: String) {
        self.introImage = introImage
        self.introTitle = introTitle
        self.introDetails = introDetails
    }
}

class IntroDataBank {
    var introDataArray: [IntroData] = []
    
    init() {
        introDataArray.append(IntroData(introImage: "vector1", introTitle: "أفضل المعلمين على المنصة", introDetails: "للمصممين نص لوريم ايبسوم بالعربي عربي انجليزي لوريم ايبسوم هو نموذج افتراضي"))
        introDataArray.append(IntroData(introImage: "vector2", introTitle: "أفضل المعلمين على المنصة", introDetails: "للمصممين نص لوريم ايبسوم بالعربي عربي انجليزي لوريم ايبسوم هو نموذج افتراضي"))
        introDataArray.append(IntroData(introImage: "vector3", introTitle: "أفضل المعلمين على المنصة", introDetails: "للمصممين نص لوريم ايبسوم بالعربي عربي انجليزي لوريم ايبسوم هو نموذج افتراضي"))
    }
}

