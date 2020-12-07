//
//  NewsResponse.swift
//  NYNews
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class NewsResponse: Mappable {
    
    var status: String?
    var copyright: String?
    var numResults: Int?
    var newsList: [NewsDetail] = []
    
    // Map the NewsResponse properties
    func mapping(map: Map) {
        status <- map["status"]
        copyright <- map["copyright"]
        numResults <- map["num_results"]
        newsList <- map["results"]
    }
    required init?(map: Map) {
        
    }
}

class NewsDetail: Equatable, Hashable, Mappable {
    // function to compare two NewsDetail
    static func ==(lhs: NewsDetail, rhs: NewsDetail) -> Bool {
        return (lhs.id ?? -1) == (rhs.id ?? -1)
    }
    // hash value to get valid Integer in case of nil
    var hashValue: Int {
        return id ?? -1
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(url)
    }
    
    var id: Int?
    var url: String?
    var keywords: String?
    // Generate an array of tags from the keywords separated by ";"
    var tags: [String]? {
        return keywords?.split(separator: ";").map(String.init)
    }
    var section: String?
    var byline: String?
    var type: String?
    var title: String?
    var description: String?
    var publishedDate: String?
    var source: String?
    var views: Int?
    var media: [NewsMedia]? = []
    // Get the Thumbnail image URL for the News List
    var thumbnailUrl: String? {
        return media?.first?.getImageForSize(NewsMedia.MediaSize.Thumbnail)?.url
    }
    // Get the Medium image URL for the News Detail
    var imageUrl: String? {
        return media?.first?.getImageForSize(NewsMedia.MediaSize.Medium)?.url
    }
    // Get the Medium image size to display
    var imageSize: CGSize? {
        if let image = media?.first?.getImageForSize(NewsMedia.MediaSize.Medium) {
            return CGSize(width: image.width, height: image.height)
        }
        return nil
    }
    
    // Map the NewsDetail properties
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
        keywords <- map["adx_keywords"]
        section <- map["section"]
        byline <- map["byline"]
        type <- map["type"]
        title <- map["title"]
        description <- map["abstract"]
        publishedDate <- map["published_date"]
        source <- map["source"]
        views <- map["views"]
        media <- map["media"]
    }
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
}

class NewsMedia: Mappable {
    
    var type: String?
    var subType: String?
    var caption: String?
    var copyright: String?
    var approved: Int?
    var metadata: [MediaMetadata]? = []
    // Set the Media size Enum to be used for retrieving images sizes
    enum MediaSize: String {
        case Thumbnail = "Standard Thumbnail"
        case Medium = "mediumThreeByTwo440"
    }
    // Function to get the MediaMetadata for the requested size
    func getImageForSize(_ size: MediaSize) -> MediaMetadata? {
        if let image = metadata?.first(where: { $0.format == size.rawValue }) {
            return image
        }
        return metadata?.filter { $0.format != MediaSize.Thumbnail.rawValue }.first
    }
    // Map the NewsMedia properties
    func mapping(map: Map) {
        type <- map["type"]
        subType <- map["subtype"]
        caption <- map["caption"]
        copyright <- map["copyright"]
        approved <- map["approved_for_syndication"]
        metadata <- map["media-metadata"]
    }
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
}

class MediaMetadata: Mappable {
    
    var url: String?
    var format: String?
    var height: Int = 0
    var width: Int = 0
    // Map the MediaMetadata properties
    func mapping(map: Map) {
        url <- map["url"]
        format <- map["format"]
        height <- map["height"]
        width <- map["width"]
    }
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
}

