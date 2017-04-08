//
//  Song.swift
//  Spot
//
//  Created by Brenda Saavedra on 08/04/17.
//  Copyright © 2017 Brenda Saavedra. All rights reserved.
//

import Foundation

struct Song {
    var name: String!
    var type: String!
    var urlImage: URL!
    var urlPreview: URL!
    
    init(fromData item:JSONStandard){
        name = item["name"] as! String
        type = item["type"] as! String
        
        let strPreview = item["preview_url"] as! String
        urlPreview = URL(string: strPreview)
        
        
        if let album = item["album"] as? JSONStandard {
            if let images = album["images"] as? [JSONStandard] {
                let imageData = images[0]
                let strUrl = imageData["url"] as! String
                
                urlImage = URL(string: strUrl)
            }
        }
        
    }
}
