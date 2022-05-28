//
//  AddMovie.swift
//  movie
//
//  Created by abdulla hmaher on 10/25/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import UIKit
import Firebase


class AddMovie: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  

    @IBOutlet var Imageview: UIImageView!
    @IBOutlet var MovienameField: UITextField!
    @IBOutlet var YearField: UITextField!
    @IBOutlet var RateField: UITextField!
    @IBOutlet var categorySelection: UIPickerView!
    @IBOutlet var MovieTrailer: UITextField!
    @IBOutlet var moviecategory: UILabel!
    
    
    
   // private var MovieListener: ListenerRegistration!
    
    
    
   
   // var pickerviewselected : String?
    private let categoryarray = ["Action", "Drama", "Family", "Comedy", "Adventure"] // we made array for the pickerview

    
    var imageupload : UIImage? = nil
    

    var MRUL : String = ""
    
    @IBAction func addbtn(_ sender: Any) {
        guard let imageselected = self.imageupload else {// i must do let inside the the function
            print("there is no image")
            return}
        
        
        guard let imagedata = imageselected.jpegData(compressionQuality: 0.4) else {return}
        
       let storageRef = Storage.storage().reference(forURL: "gs://movie-project-ed1ab.appspot.com")
        let movieimages = storageRef.child(MovienameField.text!) //named the folder and corresponding the movie image with movie name
        let metadata = StorageMetadata() // contains commen priorities to descibe the data file
        metadata.contentType = "image/jpg" //this gonna be the type of the images
        movieimages.putData(imagedata, metadata: metadata) { (storageMetaData, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            movieimages.downloadURL(completion: { (url, error) in // to get the image URL and converte it into string
                if let metaimageURL = url?.absoluteString{
                    print(metaimageURL)
                    imageURL = metaimageURL
                    if self.moviecategory.text == self.moviecategory.text{
                        Firestore.firestore().collection("Movies").document(self.MovienameField.text!).setData([
                            movieCategory : self.moviecategory.text!,
                            movieName : self.MovienameField.text!,
                            movieYear : self.YearField.text!,
                            movieRate : self.RateField.text!,
                            movieTra : self.MovieTrailer.text!,
                            movieURl : imageURL!
                            
                        ]) { (err) in
                            if let err = err {
                                
                                debugPrint("Error adding document: \(err)") } else {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            })
        }
        
            }
    let imagepickercontroller = UIImagePickerController()
    
    @IBAction func addimagebtn(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Photot source", message: "Choose a source", preferredStyle: .actionSheet) // we create actionsheet with title and message
        imagepickercontroller.delegate = self
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in // to create the camera option
            self.imagepickercontroller.sourceType = .camera
            self.present(self.imagepickercontroller, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: {(action:UIAlertAction) in // photo library option
            self.imagepickercontroller.sourceType = .photoLibrary
            self.present(self.imagepickercontroller, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil)) // cancel option
        self.present(actionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { // to make the photo appear on the imageview
        let imageselected = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        Imageview.image = imageselected
        imageupload = imageselected
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        categorySelection.dataSource = self
        categorySelection.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
}
extension AddMovie:  UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { // the number of columns
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { // the number of rows which is taken from the array above
        return categoryarray.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { // pass the selected category into the label to save it in the label
        moviecategory.text = categoryarray[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {// to show the category in the pickerview
        return categoryarray[row]
    }
}

