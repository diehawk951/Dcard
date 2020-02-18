//
//  DcardClient.swift
//  Dcard
//
//  Created by 梁嘉峻 on 2020/2/6.
//  Copyright © 2020 梁嘉峻. All rights reserved.
//

import Foundation
import UIKit
struct DcardClient {
    
    static var shared = DcardClient()
    
    func getDecard(urlString: String, completionHandler: @escaping ([Feed]?) -> ()) {
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, respose, error) in
                let decoder = JSONDecoder()
                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                    let data = try decoder.singleValueContainer().decode(String.self)
                    return dateFormatter.date(from: data) ?? Date()
                })
                
                //                decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                //                    let data = try
                //                        decoder.singleValueContainer().decode(String.self)
                //                    let dateFormatter = ISO8601DateFormatter()
                //                    dateFormatter.formatOptions = [.withInternetDateTime,.withFractionalSeconds]
                //                    print(data)
                //                    return dateFormatter.date(from: data) ?? Date()
                //                })
                
                if let data = data {
                    do {
                        _ = try decoder.decode([Feed].self, from: data)
                    } catch {
                        print(error)
                    }
                    let feed = try? decoder.decode([Feed].self, from: data)
                    completionHandler(feed)
                }else{
                    completionHandler(nil)
                }
            }.resume()
        }
    }
    
    func getImage(urlStr: String?, completionHandler: @escaping(UIImage?) -> ()) {
        if let url = URL(string: urlStr!) {
            URLSession.shared.dataTask(with: url) { (data, respose, error) in
                if let data = data, let image = UIImage(data: data) {
                    completionHandler(image)
                }else{
                    completionHandler(nil)
                }
            }.resume()
        }
    }
    
    
    
    
}
