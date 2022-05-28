//
//  movieTableCell.swift
//  movie
//
//  Created by abdulla hmaher on 10/27/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import UIKit
import Firebase

class movieTableCell: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var movie : [tableCell] = []
     @IBOutlet var tableview: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        setListener()
        // Do any additional setup after loading the view.
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: "CV", for: indexPath) as? MovieCell {
            cell.configureCell(movie: movie[indexPath.row])
            return cell
        }else {
            return UITableViewCell()
        }
    }
    var deleteRef : String = ""
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ref = Firestore.firestore().collection("Movies").document(movie[indexPath.row].MovieName)
            ref.delete()
            movie.remove(at: indexPath.row)
            
            tableview.beginUpdates()
            tableview.deleteRows(at: [indexPath], with: .automatic)
            tableview.endUpdates()
            
            tableview.reloadData() // to reload the data after detelting form the database
        }
    }
    
    @IBAction func logoutbtn(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signoutError as NSError {
            debugPrint("Error signing out: \(signoutError)")
        }
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user == nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                self.present(loginVC, animated: true, completion: nil)
            } else {
                self.setListener()
            }
        })
    }
  func setListener(){
        
        Firestore.firestore().collection("Movies").addSnapshotListener {(snapshot, error) in
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
                    let url = data[movieTra] as? String ?? ""
                    let doucmentId = document.documentID
                    
                    let storageRef =  Storage.storage().reference()
                    //named the folder and corresponding the movie image with movie name
                    
                    // Create a reference to the file you want to download
                    let tempimage = storageRef.child(name)
                    tempimage.getData(maxSize: 100000000, completion: { (data11, Er) in
                        if Er == nil {
                            let newMovie = tableCell(Image: UIImage(data: data11!) ?? UIImage(), movieName: name , movieYear: year, movieCategory: category, movieRate: rate, movieUrl: url)
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
}
