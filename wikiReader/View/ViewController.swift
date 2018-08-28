//
//  ViewController.swift
//  wikiReader
//
//  Created by Darko Dujmovic on 28/08/2018.
//  Copyright © 2018 Darko Dujmovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var articlesPickerCollectionView: UICollectionView!
    @IBOutlet weak var articleContentView: UITextView!
    
    var manuallySelectedArticleIndex:Int?
    
    var articles = [ArticleHeader](){
        didSet{
            //reload top collection view
            DispatchQueue.main.async { [weak self] in
                 self?.articlesPickerCollectionView.reloadData()
                
                if self?.manuallySelectedArticleIndex == nil{
                    self?.articleContentView.text = "Press on an article to show more data..."
                }
            }
           
        }
    }
    let batchSize = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        articleContentView.text = nil

        //Configure collection view
        registerCellNib()
        configureCollectionView()
        
        //Put batch size to limit the number of articles
        loadArticlesFromWiki(withArticleLimit: batchSize)
        
    }
    
    func registerCellNib(){
        let nib = UINib(nibName: "ArticleTitleCollectionViewCell", bundle: nil)
        self.articlesPickerCollectionView.register(nib, forCellWithReuseIdentifier: "articleCell")
    }
    
    func configureCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: articlesPickerCollectionView.frame.width*0.8, height: articlesPickerCollectionView.frame.height*0.8)
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10)
        articlesPickerCollectionView.collectionViewLayout = layout
    }
    
    func loadArticlesFromWiki(withArticleLimit articleLimit:Int){
        WikiArticleFetcher.fetchArticles(withNumberOfArticles: articleLimit) { [weak self] articles in
            guard let newArticles = articles else { return }
            self?.articles += newArticles
        }
    }

}

extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = articlesPickerCollectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as! ArticleTitleCollectionViewCell
        cell.backgroundColor = .red
        cell.articleTitle.text = articles[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArticleTitle = articles[indexPath.row].title
        WikiArticleDetailFetcher.fetchDetails(articleTitle: selectedArticleTitle) { (articleHeader) in
            print("")
        }
        print("")
    }
}

