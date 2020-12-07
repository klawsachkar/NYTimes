//
//  CoreDataManager.swift
//  NYNews
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import Foundation
import CoreData
import SugarRecord

class CoreDataManager: NSObject {
    
    // This is the "shared" instance of this class that is created only once
    static let shared = CoreDataManager()
    private let PersistentModelName = "NYNews"
    private var database: CoreDataDefaultStorage!
    private var context: NSManagedObjectContext!
    
    private override init() {
        super.init()
        // Initialize the context of the Database
        let store = CoreDataStore.named(PersistentModelName)
        let model = CoreDataObjectModel.named(PersistentModelName, Bundle.main)
        database = try! CoreDataDefaultStorage(store: store, model: model)
        context = database.mainContext as? NSManagedObjectContext
    }
    
    func newsDetailExists(_ id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<NYNewsDetail> = NYNewsDetail.fetchRequest()
        // Get specific News Detail by Id
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
        do {
            return try context.fetch(fetchRequest).count > 0
        } catch {
            return false
        }
    }
    
    func getNewsDetailsList() -> [NYNewsDetail]? {
        // Get all saved NYNewsDetail
        let fetchRequest: NSFetchRequest<NYNewsDetail> = NYNewsDetail.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    func saveNewsData(newsList: [NewsDetail], completion: @escaping (_ success: Bool, _ Error: Error?) -> Void) {
        // Loop over the list of News to save them
        newsList.forEach { (newsDetail) in
            // Check the existance of News Detail by Id
            if newsDetailExists(newsDetail.hashValue) == false {
                // If the News Detail doesnt exist, create it
                let nyNewsDetail = NYNewsDetail(context: context)
                // Set the NewsDetail properties
                nyNewsDetail.id = String(newsDetail.hashValue)
                nyNewsDetail.byline = newsDetail.byline
                nyNewsDetail.desc = newsDetail.description
                nyNewsDetail.keywords = newsDetail.keywords
                nyNewsDetail.publishedDate = newsDetail.publishedDate
                nyNewsDetail.section = newsDetail.section
                nyNewsDetail.source = newsDetail.source
                nyNewsDetail.title = newsDetail.title
                nyNewsDetail.type = newsDetail.type
                nyNewsDetail.url = newsDetail.url
                nyNewsDetail.views = Int32(newsDetail.views ?? 0)
                // Set the Media list
                newsDetail.media?.forEach({ (newsMedia) in
                    let nyNewsMedia = NYNewsMedia(context: context)
                    nyNewsMedia.approved = Int32(newsMedia.approved ?? 0)
                    nyNewsMedia.caption = newsMedia.caption
                    nyNewsMedia.copyright = newsMedia.copyright
                    nyNewsMedia.type = newsMedia.type
                    nyNewsMedia.subType = newsMedia.subType
                    nyNewsMedia.newsDetail = nyNewsDetail
                    // Set the Metadata List
                    newsMedia.metadata?.forEach({ (mediaMetadata) in
                        let nyMediaMetadata = NYMediaMetadata(context: context)
                        nyMediaMetadata.format = mediaMetadata.format
                        nyMediaMetadata.width = Int32(mediaMetadata.width)
                        nyMediaMetadata.height = Int32(mediaMetadata.height)
                        nyMediaMetadata.url = mediaMetadata.url
                        nyMediaMetadata.newsMedia = nyNewsMedia
                    })
                })
            }
        }
        // Save the context.
        do {
            try saveContext()
            completion(true, nil)
        } catch {
            completion(false, error)
        }
    }
    
    func saveContext() throws {
        // Save the context
        try context.save()
        // Save as well the parent up to the last level
        var contextParent = context.parent
        while contextParent != nil {
            try contextParent?.save()
            contextParent = contextParent?.parent
        }
    }
    
    func getLastSavedNews() -> [NewsDetail] {
        // get the last saved News Details
        if let newsDetailsList = getNewsDetailsList(),
            newsDetailsList.count > 0 {
            // Convert the list into NewsDetail
            let newsList = newsDetailsList.sorted(by: { (ny1, ny2) -> Bool in
                return ny1.publishedDate ?? "" > ny2.publishedDate ?? ""
            }).map { (nyNewsDetail) -> NewsDetail in
                let newsDetail = NewsDetail()
                // Set the NewsDetail properties
                newsDetail.id = Int(nyNewsDetail.id ?? "0")
                newsDetail.byline = nyNewsDetail.byline
                newsDetail.description = nyNewsDetail.desc
                newsDetail.keywords = nyNewsDetail.keywords
                newsDetail.publishedDate = nyNewsDetail.publishedDate
                newsDetail.section = nyNewsDetail.section
                newsDetail.source = nyNewsDetail.source
                newsDetail.title = nyNewsDetail.title
                newsDetail.type = nyNewsDetail.type
                newsDetail.url = nyNewsDetail.url
                newsDetail.views = Int(nyNewsDetail.views)
                // Set the Media list
                newsDetail.media = nyNewsDetail.newsMediaList?.map({ (media) -> NewsMedia in
                    let nyNewsMedia = media as! NYNewsMedia
                    let newsMedia = NewsMedia()
                    newsMedia.approved = Int(nyNewsMedia.approved)
                    newsMedia.caption = nyNewsMedia.caption
                    newsMedia.copyright = nyNewsMedia.copyright
                    newsMedia.type = nyNewsMedia.type
                    newsMedia.subType = nyNewsMedia.subType
                    // Set the Metadata List
                    newsMedia.metadata = nyNewsMedia.mediaMetadataList?.map({ (meta) -> MediaMetadata in
                        let nyNewsMetadata = meta as! NYMediaMetadata
                        let mediaMetadata = MediaMetadata()
                        mediaMetadata.format = nyNewsMetadata.format
                        mediaMetadata.width = Int(nyNewsMetadata.width)
                        mediaMetadata.height = Int(nyNewsMetadata.height)
                        mediaMetadata.url = nyNewsMetadata.url
                        return mediaMetadata
                    })
                    return newsMedia
                })
                return newsDetail
            }
            return newsList
        }
        return [NewsDetail]()
    }
}
