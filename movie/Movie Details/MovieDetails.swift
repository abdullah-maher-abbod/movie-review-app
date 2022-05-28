//
//  MovieDetails.swift
//  movie
//
//  Created by abdulla hmaher on 10/28/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import UIKit
import SafariServices
import Firebase

class MovieDetails: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    private var thoughtsListener: ListenerRegistration!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return thoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as? ThoughCell {
            cell.configureCell(thought: thoughts[indexPath.row])
           
            cell.usernamelbl.numberOfLines = 3
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    

    @IBOutlet var textview: UITextView!
    @IBOutlet var username: UITextField!
    @IBOutlet var RateLbl: UILabel!
    @IBOutlet var categoryLbl: UILabel!
    @IBOutlet var YearLbl: UILabel!
    @IBOutlet var movieLbl: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var tabaleview: UITableView!
    
    private var thoughts = [Thought]()
    
    var video : userTableCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        tabaleview.delegate = self
        tabaleview.dataSource = self
        
        setListener()

    }
    
    @IBAction func postbtn(_ sender: Any) {
        guard let username = username.text else { return }
        Firestore.firestore().collection("thoughts").addDocument(data: [
            movieusername : username,
            moviecomment : textview.text,
            movieName : movieLbl.text
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err)")
            } else {
                
            }
        }
    }
    func setUI(){
        image.image = video?.image
        RateLbl.text = video?.MovieRate
        categoryLbl.text = video?.MovieCategory
        YearLbl.text = video?.MovieYear
        movieLbl.text = video?.MovieName
    }
    override func viewWillDisappear(_ animated: Bool) {
        if thoughtsListener != nil {
            thoughtsListener.remove()
        }
    }
    func setListener() {
        
   
        thoughtsListener = Firestore.firestore().collection("thoughts").whereField(movieName, isEqualTo: movieLbl.text ?? "").addSnapshotListener {(snapshot, error) in
                if let err = error {
                    debugPrint("Error fetching docs: \(err)")
                } else {
                    
                    guard let snap = snapshot else {return}
                    for document in snap.documents {
                        let data = document.data()
                        let username = data[movieusername] as? String ?? ""
                        let time = data[commentTime] as? Date ?? Date()
                        let textthought = data[moviecomment] as? String ?? ""
                        let moviename = data[movieName] as? String ?? ""
                        let doucmentId = document.documentID
                        self.thoughts.removeAll()
                        let newComment = Thought(username: username, timstamp: time, thoughtTxt: textthought, moviename: moviename, documentId: doucmentId)
                        self.thoughts.append(newComment)
                    }
                    self.thoughts = Thought.parseData(snapshot: snapshot)
                    self.tabaleview.reloadData()
                }
            }
    
        
    }
    @IBAction func watchbtn(_ sender: Any) {
        
        if let video = video {
           
         let movieURL = URL(string: video.MovieURl)
            let safariVC = SFSafariViewController(url: movieURL!)
            present(safariVC, animated: true, completion:  nil)
        }
    }
    
    

}

