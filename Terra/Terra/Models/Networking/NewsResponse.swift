//
//  NewsResponse.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/8/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct NewsResponse: Decodable {
    let articles: [NewsArticle]?
}
