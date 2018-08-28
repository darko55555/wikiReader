//
//  WikiArticleFetcher.swift
//  wikiReader
//
//  Created by Darko Dujmovic on 28/08/2018.
//  Copyright © 2018 Darko Dujmovic. All rights reserved.
//

import Foundation

class WikiArticleFetcher{
    
    static func generateWikiFetchURL(withNumberOfArticles numberOfArticles:Int)-> URL?{
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "en.wikipedia.org"
        urlComponents.path = "/w/api.php"
        
        let formatQuery = URLQueryItem(name: "format", value: "json")
        let actionQuery = URLQueryItem(name: "action", value: "query")
        let generatorQuery = URLQueryItem(name: "generator", value: "random")
        let grnnamespaceQuery = URLQueryItem(name: "grnnamespace", value: "0")
        let articleLimit = URLQueryItem(name: "grnlimit", value: String(numberOfArticles))
        
        urlComponents.queryItems = [formatQuery, actionQuery, generatorQuery, grnnamespaceQuery, articleLimit]
        
        return urlComponents.url
    }
    
    static func fetchArticles(withNumberOfArticles numberOfArticles:Int, completion:@escaping ([ArticleHeader]?)->()){
        guard let url = generateWikiFetchURL(withNumberOfArticles: numberOfArticles) else { return }
        
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
                        let responseObject = try decoder.decode(WikiHeaderResponseModel.self, from: data)
                        completion(Array(responseObject.query.pages.values))
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
