//
//  Thought.swift
//  movie
//
//  Created by abdulla hmaher on 10/28/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Thought {
    
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var thoughtTxt: String!
    private(set) var moviename : String!
    private(set) var documentId : String!
    
    init(username: String, timstamp: Date, thoughtTxt: String, moviename: String, documentId: String) {
        
        self.username = username
        self.timestamp = timstamp
        self.thoughtTxt = thoughtTxt
        self.moviename = moviename
        self.documentId = documentId
       
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Thought] {
        var thoughts = [Thought]()
        
        guard let snap = snapshot else { return thoughts }
        for document in snap.documents {
            let data = document.data()
            
            let username = data[movieusername] as? String ?? ""
            let CommentTime = data[commentTime] as? Date ?? Date()
            let thoughtTxt = data[moviecomment] as? String ?? ""
            let mName = data[movieName] as? String ?? ""
            let documentId = document.documentID
            
            let newThought = Thought(username: username, timstamp: CommentTime, thoughtTxt: thoughtTxt, moviename: mName, documentId: documentId)
            thoughts.append(newThought)
        }
        
        return thoughts
}
}
