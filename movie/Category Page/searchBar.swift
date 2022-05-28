//
//  searchBar.swift
//  movie
//
//  Created by abdulla hmaher on 10/28/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import UIKit
import Firebase
enum ThoughtCategory : String {
    case Action = "Action"
    case Drama = "Drama"
    case Family = "Family"
    case Comedy = "Comedy"
    case Adventure = "Adventure"
}
class searchBar: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var selectedCategory = ThoughtCategory.Action.rawValue
    private var thoughtsListener: ListenerRegistration!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tode" {
            let destVC = segue.destination as! MovieDetails
            destVC.video =  sender as? userTableCell
        }
    }
    
    var searchcategory = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        setListener()
    }
    
    var movie : [searchTableCell] = []
    private let categoryarray = ["Action", "Drama", "Family", "Comedy", "Adventure"]
    @IBOutlet var tableview: UITableView!
    var searching = false
    
   
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
           return categoryarray.count
            print("thing")
        }else{
            return movie.count
            print("nothing")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: "CV", for: indexPath) as? searchMovieTableCell {
            cell.configureCell(searchmovie: movie[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = movie[indexPath.row]
        performSegue(withIdentifier: "tode", sender: video)
        
    }
    
    func setListener(){
        
        Firestore.firestore().collection("Movies").whereField(movieCategory, isEqualTo: selectedCategory).addSnapshotListener {(snapshot, error) in
                if let err = error {
                    debugPrint("Error fetching docs: \(error)")
                } else {
                    self.movie.removeAll()
                    guard let snap = snapshot else {return}
                    for document in snap.documents {
                        let data = document.data()
                        let image = data[movieURl] as? UIImage  ?? UIImage()
                        let name = data[movieName] as? String ?? ""
                        let year = data[movieYear] as? String ?? ""
                        let category = data[movieCategory] as? String ?? ""
                        let rate = data[movieRate] as? String ?? ""
                        let tra = data[movieTra] as? String ?? ""
                        let doucmentId = document.documentID
                        
                        let storageRef =  Storage.storage().reference()
                        
                        
                        // Create a reference to the file you want to download
                        let tempimage = storageRef.child(name)
                        tempimage.getData(maxSize: 100000000, completion: { (data11, Er) in
                            if Er == nil {
                                
                                let newMovie = searchTableCell(Image: UIImage(data: data11!)!, movieName: name , movieYear: year, movieCategory: category, movieRate: rate, movieUrl: tra)
                                self.movie.append(newMovie)
                            }
                            else {
                                print("image in not foundd")
                            }
                            
                            self.tableview.reloadData()
                        })
                    }
                }
            }
        
        
    }
//    let filteredQuery = query.whereField("category", isEqualTo: "Dim Sum")
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBAction func categoryChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex  {
        case 0:
        selectedCategory = ThoughtCategory.Action.rawValue
            
        case 1:
        selectedCategory = ThoughtCategory.Drama.rawValue
        case 2:
        selectedCategory = ThoughtCategory.Family.rawValue
        case 3:
        selectedCategory = ThoughtCategory.Adventure.rawValue
        default:
        selectedCategory = ThoughtCategory.Comedy.rawValue
    }
        setListener()
    }
}
