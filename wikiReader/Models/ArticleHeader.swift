//
//  ArticleHeader.swift
//  wikiReader
//
//  Created by Darko Dujmovic on 28/08/2018.
//  Copyright © 2018 Darko Dujmovic. All rights reserved.
//

import Foundation

class ArticleHeader:Codable{
    let pageid:UInt64
    let title:String
    let ns:Int
    
    init(pageid:UInt64, title:String, ns:Int){
        self.pageid = pageid
        self.title = title
        self.ns = ns
    }
    
}

