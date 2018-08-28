//
//  ArticleModel.swift
//  wikiReader
//
//  Created by Darko Dujmovic on 28/08/2018.
//  Copyright © 2018 Darko Dujmovic. All rights reserved.
//

import Foundation


class ArticleModel:Codable{
    let pageid:UInt64
    let title:String
    let ns:Int
    var extract:String?
    
    init(pageid:UInt64, title:String, ns:Int, extract:String?){
        self.pageid = pageid
        self.title = title
        self.ns = ns
        self.extract = extract
    }
    
}
