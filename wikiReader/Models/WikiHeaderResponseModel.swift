//
//  WikiResponseModel.swift
//  wikiReader
//
//  Created by Darko Dujmovic on 28/08/2018.
//  Copyright © 2018 Darko Dujmovic. All rights reserved.
//

import Foundation

class WikiHeaderResponseModel:Codable{
    let query:Pages
    
    init(query:Pages){
        self.query = query
    }
    
    private enum CodingKeys: String, CodingKey{
        case query
    }
}

class Pages:Codable{
    var pages:[String:ArticleHeader]
    
    init(pages:[String:ArticleHeader]){
        self.pages = pages
    }
}
