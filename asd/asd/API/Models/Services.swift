//
//  Services.swift
//  asd
//
//  Created by Vasiliy Samuilik on 5/8/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import Foundation
import Firebase

// MARK: - Services

struct Services: Codable, ParseModel, Equatable {
    var id: String = ""
    
    let name: String
    let image: String
    let price: String
    let amount: String
    let about: String
    let comfort: String
    let equipment: String
    let instructor: String
    let plan: String
    let time: String
    let water: String
}

// MARK: - Coding

extension Services {
    
    private enum CodingKeys : String, CodingKey {
        case name, image, price, amount, about, comfort, equipment, instructor, plan, time, water
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        price = try container.decode(String.self, forKey: .price)
        amount = try container.decode(String.self, forKey: .amount)
        about = try container.decode(String.self, forKey: .about)
        comfort = try container.decode(String.self, forKey: .comfort)
        equipment = try container.decode(String.self, forKey: .equipment)
        instructor = try container.decode(String.self, forKey: .instructor)
        plan = try container.decode(String.self, forKey: .plan)
        time = try container.decode(String.self, forKey: .time)
        water = try container.decode(String.self, forKey: .water)
    }
    
    public func encode(to encoder: Encoder) throws { }
    
}

