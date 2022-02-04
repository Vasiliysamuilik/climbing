// 
//  Record.swift
//  asd
//
//  Created by Vasiliy Samuilik on 5/23/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import Foundation

// MARK: - Record

struct Record: Codable, ParseModel, Equatable {
    var id: String = ""
    
    var clientName: String
    var phone: String
    var date: Date
    var serviceId: String
    
    func map() -> [String : Any] {
        return ["clientName" : clientName,
                "phone" : phone,
                "date" : date,
                "serviceId" : serviceId]
    }
}

// MARK: - Coding

extension Record {
    
    private enum CodingKeys : String, CodingKey {
        case clientName, phone, date, serviceId
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        clientName = try container.decode(String.self, forKey: .clientName)
        phone = try container.decode(String.self, forKey: .phone)
        date = try container.decode(Date.self, forKey: .date)
        serviceId = try container.decode(String.self, forKey: .serviceId)
    }
    
    public func encode(to encoder: Encoder) throws { }
    
}
