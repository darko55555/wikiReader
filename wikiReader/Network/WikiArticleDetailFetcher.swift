//
//  WikiArticleDetailFetcher.swift
//  wikiReader
//
//  Created by Darko Dujmovic on 28/08/2018.
//  Copyright © 2018 Darko Dujmovic. All rights reserved.
//

import Foundation

class WikiArticleDetailFetcher{
    
    static func generateWikiArticleDetails(forArticleTitle articleTitle:String)-> URL?{
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "en.wikipedia.org"
        urlComponents.path = "/w/api.php"
        
        let formatQuery = URLQueryItem(name: "format", value: "json")
        let actionQuery = URLQueryItem(name: "action", value: "query")
        let propQuery = URLQueryItem(name: "prop", value: "extracts")
        let exintroQuery = URLQueryItem(name: "exintro", value: "")
        let explaintextQuery = URLQueryItem(name: "explaintext", value: "")
        
        let articleTitle = articleTitle.replacingOccurrences(of: " ", with: "")
        let titles = URLQueryItem(name: "titles", value: articleTitle)
        
        urlComponents.queryItems = [formatQuery, actionQuery, propQuery, exintroQuery,explaintextQuery, titles]
        
        return urlComponents.url
    }
    
    static func fetchDetails(articleTitle:String, completion:@escaping (ArticleModel?)->()){
        guard let url = generateWikiArticleDetails(forArticleTitle: articleTitle) else { return }
        
        let request = URLRequest(url: url)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error{
                print("An error occured fetching articles \(error.localizedDescription)")
            }else{
                guard let response = response as? HTTPURLResponse else { return }
                
                switch response.statusCode{
                case 200..<300:
                    guard let data = data else { return }
                    do{
                        let decoder = JSONDecoder()
                        let responseObject = try decoder.decode(WikiDetailsResponseModel.self, from: data)
                        completion(responseObject.query.pages.values.first)
                        print("")
                    }catch let error{
                        print("Error parsing JSON \(error.localizedDescription)")
                        completion(nil)
                    }
                    
                default:
                    print("An error occured fetching articles with status code \(response.statusCode)")
                    completion(nil)
                    return
                }
                
            }
        })
        task.resume()
        
    }
}
