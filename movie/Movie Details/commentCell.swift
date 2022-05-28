//
//  commentCell.swift
//  movie
//
//  Created by abdulla hmaher on 10/28/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//


import UIKit
//import Firebase


class ThoughCell : UITableViewCell{
    
    @IBOutlet var commentlbl: UILabel!
    @IBOutlet var timelbl: UILabel!
    @IBOutlet var usernamelbl: UILabel!
    
    private var thought: Thought!
    
    func configureCell(thought: Thought) {
        self.thought = thought
        usernamelbl.text = thought.username
        commentlbl.text = thought.thoughtTxt
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: thought.timestamp)
        timelbl.text = timestamp
    }}
