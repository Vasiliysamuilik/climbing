//
//  ParseFirebase.swift
//  asd
//
//  Created by Vasiliy Samuilik on 4/16/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

// MARK: - FirebaseManager

extension FirebaseManager {

    func parseError<T>(data: T?, error: Error?) throws -> T {
        if let error = error {
            print("Error \(error.localizedDescription)")
            throw error
        } else {
            guard let data = data else {
                print("Error \(FirebaseError.resultDataNil.localizedDescription)")
                throw FirebaseError.resultDataNil
            }
            //print("Data loaded: \(data)")
            return data
        }
    }
    
    func parseDocumentSnapshot<T: Codable & ParseModel>(_ data: DocumentSnapshot) throws -> T {
        let id = data.documentID
        guard let data = data.data() else {
            print("Error \(FirebaseError.resultDataEmpty.localizedDescription)")
            throw FirebaseError.resultDataEmpty
        }
        //print("Data loaded: \(data)")
        var value: T = try Firestore.Decoder().decode(T.self, from: data)
        value.id = id
        return value
    }
    
    func parseQuerySnapshot<T: Codable & ParseModel>(_ data: QuerySnapshot) throws -> [T] {
        return try data.documents.compactMap { (item) -> T? in
            return try parseDocumentSnapshot(item)
        }
    }
    
    func parseJSONObjects<T: Codable & ParseModel>(_ data: [[String : Any]]) throws -> [T] {
        return try data.compactMap({ (item) -> T? in
            var value: T = try Firestore.Decoder().decode(T.self, from: item)
            if let id = item["documentID"] as? String {
                value.id = id
            }
            return value
        })
    }
    
}
