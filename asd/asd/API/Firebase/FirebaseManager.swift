//
//  FirebaseManager.swift
//  asd
//
//  Created by Vasiliy Samuilik on 4/22/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import Firebase
import FirebaseFirestore

enum Result<T> {
    case value(T)
    case error(Error)
}

struct Response<T> {
    var array: [T]
    var object: T { return array.first! }
}

protocol ParseModel {
    var id: String { get set }
}

// MARK - FirebaseError

enum FirebaseError: Error {
    case resultDataNil
    case resultDataEmpty
    case parsing
}

extension FirebaseError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .resultDataNil:    return "Haven't result data"
        case .resultDataEmpty:  return "Result data is empty"
        case .parsing:          return "Parsing error"
        }
    }
    
}

// MARK - FirebaseManager

class FirebaseManager {

    static let shared = FirebaseManager()

    let firestore: Firestore!

    enum Collections: String {
        case news = "news"
        case records = "records"
        case services = "services"
    }

    
    init() {
        FirebaseApp.configure()
        firestore = Firestore.firestore()
    }

}
