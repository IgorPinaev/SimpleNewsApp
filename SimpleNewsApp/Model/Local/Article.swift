//
//  Article.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import Foundation
import CoreData

class Article: NSManagedObject {
    @NSManaged var title: String?
    @NSManaged var desc: String?
    @NSManaged var url: String?
    @NSManaged var urlToImage: String?
    @NSManaged var publishedAt: Date?
    
    static func from(_ articleStruct: ArticleStruct, context: NSManagedObjectContext = CoreDataService.instance.context) {
        let article = Article(context: context)
        
        article.title = articleStruct.title
        article.desc = articleStruct.description
        article.url = articleStruct.url
        article.urlToImage = articleStruct.urlToImage
        article.publishedAt = articleStruct.publishedAt
    }
}
