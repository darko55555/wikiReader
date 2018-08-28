//
//  ArticleDetailsModel.swift
//  wikiReader
//
//  Created by Darko Dujmovic on 28/08/2018.
//  Copyright © 2018 Darko Dujmovic. All rights reserved.
//

import Foundation

class WikiDetailsResponseModel:Codable{
    let query:PagesDetails
    
    init(query:PagesDetails){
        self.query = query
    }
    
    private enum CodingKeys: String, CodingKey{
        case query
    }
}

class PagesDetails:Codable{
    var pages:[String:ArticleModel]
    
    init(pages:[String:ArticleModel]){
        self.pages = pages
    }
}

