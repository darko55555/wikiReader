//
//  ArticleTitleCollectionViewCell.swift
//  wikiReader
//
//  Created by Darko Dujmovic on 28/08/2018.
//  Copyright © 2018 Darko Dujmovic. All rights reserved.
//

import UIKit

class ArticleTitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var articleTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .green
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleTitle.text = nil
    }
}
