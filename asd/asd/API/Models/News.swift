//
//  Program.swift
//  asd
//
//  Created by Vasiliy Samuilik on 4/16/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import Foundation
import Firebase

// MARK: - News

struct News: Codable, ParseModel, Equatable {
    var id: String = ""
    
    let title: String
    let images: [String]
    let body: String
    
}

// MARK: - Coding

extension News {
    
    private enum CodingKeys : String, CodingKey {
        case title, images, body
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        images = try container.decode([String].self, forKey: .images)
        body = try container.decode(String.self, forKey: .body)
    }
    
    public func encode(to encoder: Encoder) throws { }
    
}
