//
//  ViewController.swift
//  movie
//
//  Created by abdulla hmaher on 8/21/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var movie : [tableCell] = []// to create a array as tablecell and make it empty coz we will add to it later
    private var MovieListener: ListenerRegistration!
    
    // Get a non-default Storage bucket
    let storage = Storage.storage().reference(forURL: "gs:movie-project-ed1ab.appspot.com/movieImages")
    
    
   var pickerviewselected = "Action"
    
   
   
  



    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        
        //MovieListener.remove()
        
    }
   
  
    
    
}

