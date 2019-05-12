//
//  PugDataManager.swift
//  TakeHomeJobox
//
//  Created by marcio romero on 5/11/19.
//  Copyright © 2019 mrp. All rights reserved.
//

import UIKit

class PugDataManager {
    
    static let serviceUrl = "https://pugme.herokuapp.com/bomb?"
    
    class func retrievePugs(count: Int, completion: @escaping (String,[Pug]) -> ()) {
        guard let fullUrl = URL(string: "\(serviceUrl)count=\(count)") else { return }
        URLSession.shared.dataTask(with: fullUrl, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else { return }
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    let rawArray = jsonResult.values.first as? [String] ?? []
                    let pugs = rawArray.map({ (imageUrl) -> Pug in
                        Pug(url: imageUrl)
                    })
                    loadPugImages(pugs,
                                  dataLabel: jsonResult.keys.first ?? "",
                                  completion: completion)
                }
            } catch {
                // handle error
            }
        }).resume()
        
    }
    
    class func loadPugImages(_ pugs: [Pug], dataLabel: String, completion: @escaping (String,[Pug]) -> ()) {
        let group = DispatchGroup()
        for pug in pugs {
            guard let imageUrl = URL(string: pug.imageURL) else { break }
            group.enter()
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) -> Void in
                guard let data = data, error == nil else { return }
                let image = UIImage(data: data)
                pug.image = image
                group.leave()
            }).resume()
        }
        group.notify(queue: .main, work: DispatchWorkItem(block: {
            completion(dataLabel,pugs)
        }))
    }
}
