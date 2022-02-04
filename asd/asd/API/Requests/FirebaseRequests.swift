//
//  UsersFirebaseRequests.swift
//  asd
//
//  Created by Vasiliy Samuilik on 4/16/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import Firebase
import FirebaseFirestore

// MARK: - FirebaseManager

extension FirebaseManager {
    
    func fetchNews(completion: @escaping (_ result: Result<Response<News>>) -> ()) {
        firestore.collection(Collections.news.rawValue).getDocuments { (result, error) in
            do {
                let data: QuerySnapshot = try self.parseError(data: result, error: error)
                let news: [News] = try self.parseQuerySnapshot(data)
                return completion(.value(Response(array: news)))
            } catch {
                return completion(.error(error))
            }
        }
        
    }
    
    func fetchServices(completion: @escaping (_ result: Result<Response<Services>>) -> ()) {
        firestore.collection(Collections.services.rawValue).getDocuments { (result, error) in
            do {
                let data: QuerySnapshot = try self.parseError(data: result, error: error)
                let services: [Services] = try self.parseQuerySnapshot(data)
                return completion(.value(Response(array: services)))
            } catch {
                return completion(.error(error))
            }
        }
        
    }
    
    func createRecord(_ record: Record, completion: @escaping (_ result: Result<Response<String>>) -> ()) {
        var ref: DocumentReference?
        ref = firestore.collection(Collections.records.rawValue)
            .addDocument(data: record.map()) { (error) in
                if let error = error {
                    completion(.error(error))
                } else {
                    completion(.value(Response(array: [ref?.documentID ?? ""])))
                }
        }
    }
    
}
