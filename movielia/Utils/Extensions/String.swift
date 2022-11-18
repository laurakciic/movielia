//
//  String.swift
//  movielia
//
//  Created by Laura on 06.11.2022..
//

import Foundation

extension String {

   func removeHTMLTags() -> String {
       return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}
