//
//  MainSlideMenuViewController.swift
//  DemoAppBeenLoveMemoryLite
//
//  Created by dohien on 28/08/2018.
//  Copyright © 2018 dohien. All rights reserved.
//

import UIKit
import os.log
import Firebase
import FirebaseAuth
import Photos
import FirebaseStorage
import FirebaseDatabase

class MainSlideMenuViewController: UIViewController , DatePickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var infor: Infor?
    var timer = Timer()
    var refArtistis: DatabaseReference?
    lazy var storage = Storage.storage()
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var nameGirlTextField: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var yearDataLabel: UILabel!
    @IBOutlet weak var monthDataLabel: UILabel!
    @IBOutlet weak var weekDataLabel: UILabel!
    @IBOutlet weak var dayDataLabel: UILabel!
    @IBOutlet weak var hourDataLabel: UILabel!
    @IBOutlet weak var minuteDataLabel: UILabel!
    @IBOutlet weak var secondDataLabel: UILabel!
    @IBOutlet weak var loveDataLabel: UILabel!
    @IBOutlet weak var photoImageBoy: DesignableUI!
    @IBOutlet weak var photoImageGirl: DesignableUI!
    @IBOutlet weak var btnTapgetNameA: UIButton!
    @IBOutlet weak var btnTapgetNameB: UIButton!
    @IBOutlet weak var photoImageLove: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let saveInfor = loadInfor() {
            infor = saveInfor
        } else {
            infor = Infor(nameBoy: "Name A", nameGirl: "Name B", photoImageBoy: photoImageBoy.image, photoImageGirl: photoImageGirl.image, dayStart: "")
        }
        loveDataLabel.text = infor!.dayStart
        nameTextField.text = infor!.nameBoy
        nameGirlTextField.text = infor!.nameGirl
        photoImageBoy.image = infor?.photoImageBoy
        photoImageGirl.image = infor?.photoImageGirl
        if loveDataLabel.text != nil {
            let _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getday), userInfo: nil, repeats: true)
        }
    }
    
    func  interval(start: Date, end: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: start) else { return 0 }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: end) else { return 0 }
        return start - end
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: {
            self.photoImageLove.frame.origin.y -= 20
        }, completion: nil)
      
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func menuBtn(_ sender: UIButton) {
        
        var alertController: UIAlertController?
        alertController = UIAlertController(title: "My lover", message: "", preferredStyle: .alert)
        alertController?.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter something"
        })
        let action = UIAlertAction(title: "Change name", style: UIAlertActionStyle.default, handler: {[weak self]
            (paramAction: UIAlertAction!) in
            if let textFields = alertController?.textFields {
                let enteredText = textFields[0].text
                self?.nameTextField.text = enteredText
                self?.infor!.nameBoy = enteredText!
                self?.saveInfor()
            }
        })
        alertController?.addAction(action)
        
        self.present(alertController!, animated: true, completion: nil)
        let key = refArtistis?.childByAutoId().key
        let artist = ["id": key,
                      "NameBoy": nameTextField.text
        ]
        refArtistis?.child(key!).setValue(artist)
    }

    
    @IBAction func menuBtnGirlName(_ sender: UIButton) {
       
        var alertController: UIAlertController?
        alertController = UIAlertController(title: "My lover", message: "", preferredStyle: .alert)
        alertController?.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter something"
        })
        let action = UIAlertAction(title: "Change name", style: UIAlertActionStyle.default, handler: {[weak self]
            (paramAction: UIAlertAction!) in
            if let textFields = alertController?.textFields {
                let enteredText = textFields[0].text
                self?.nameGirlTextField.text = enteredText
                self?.infor!.nameGirl = enteredText!
                self?.saveInfor()
                let key = self?.refArtistis?.childByAutoId().key
                let artist = ["id": key,
                              "NameBoy": self?.nameGirlTextField.text
                ]
                self?.refArtistis?.child(key!).setValue(artist)
            }
        })
        
        alertController?.addAction(action)
        self.present(alertController!, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailMainSlideMenuViewController = segue.destination as? DatePickerViewController {
            detailMainSlideMenuViewController.delegate = self
        }
    }
    
    // dữ liệu luôn mới
    
    @objc func  getday() {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        let startDate = loveDataLabel.text
        let formatedStartDate = dateFormat.date(from: startDate!)
        let currentDate = Date()
        let components = Set<Calendar.Component>([.year, .month, .weekOfMonth, .day, .hour, .minute, .second])
        if formatedStartDate != nil {
            let differenceOfDate = Calendar.current.dateComponents(components, from:  formatedStartDate!, to: currentDate)
            dateLabel.text = String(interval(start: currentDate, end: formatedStartDate!))
            yearDataLabel.text = differenceOfDate.year?.description
            monthDataLabel.text = differenceOfDate.month?.description
            weekDataLabel.text = differenceOfDate.weekOfMonth?.description
            dayDataLabel.text = differenceOfDate.day?.description
            hourDataLabel.text = differenceOfDate.hour?.description
            minuteDataLabel.text = differenceOfDate.minute?.description
            secondDataLabel.text = differenceOfDate.second?.description
        }
        else {
            dateLabel.text = ""
            yearDataLabel.text = ""
            monthDataLabel.text = ""
            weekDataLabel.text = ""
            dayDataLabel.text = ""
            hourDataLabel.text = ""
            minuteDataLabel.text = ""
            secondDataLabel.text = ""
        }
    }

    
    func senDataLove(data: String) {
        loveDataLabel.text = data
        infor?.dayStart = data
        saveInfor()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        let srartDate = data
        let formatedStartDate = dateFormat.date(from: srartDate)
        let currentDate = Date()
        let components = Set<Calendar.Component>([.year, .month, .weekOfMonth, .day, .hour, .minute,.second])
        let differenceOfDate = Calendar.current.dateComponents(components, from:  formatedStartDate!, to: currentDate)
        yearDataLabel.text = differenceOfDate.year?.description
        monthDataLabel.text = differenceOfDate.month?.description
        weekDataLabel.text = differenceOfDate.weekOfMonth?.description
        dayDataLabel.text = differenceOfDate.day?.description
        hourDataLabel.text = differenceOfDate.hour?.description
        minuteDataLabel.text = differenceOfDate.minute?.description
        secondDataLabel.text = differenceOfDate.second?.description
   
        let key = refArtistis?.childByAutoId().key
        let artist = ["id": key,
                      "year": yearDataLabel.text,
                      "month": monthDataLabel.text,
                      "week": weekDataLabel.text,
                      "day": dayDataLabel.text,
                      "hour": hourDataLabel.text,
                      "minute": minuteDataLabel.text,
                      "second": secondDataLabel.text
        ]
        let loveData = ["id": key,
                        "loveData": loveDataLabel.text
        ]
        refArtistis?.child(key!).setValue(artist)
        refArtistis?.child(key!).setValue(loveData)
        saveInfor()
    }
    
    @IBAction func selectedBtnImageA(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        check = true
        present(imagePickerController, animated: true , completion:  nil)
}
    @IBAction func selectedBtnImageB(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        check = false
        present(imagePickerController, animated: true , completion:  nil)
}
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    var check = true
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        if check
        {
            photoImageBoy.image = selectedImage
            infor?.photoImageBoy = selectedImage
            saveInfor()
            // add fire base
                guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
                guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return }
                let imagePath = Storage.storage().reference()
                imagePath.child("imagesBoy")
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                let storageRef = self.storage.reference(withPath: "imagesBoy")
                storageRef.putData(imageData, metadata: metadata) {
                    (metadata, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    storageRef.downloadURL(completion: {(url, error) in })
                    self.uploadSuccess(storageRef, storagePath: "imagesBoy")
                }
        } else {
            photoImageGirl.image = selectedImage
            infor?.photoImageGirl = selectedImage
            saveInfor()
                guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
                guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return }
                let imagePath = Storage.storage().reference()
                imagePath.child("imagesGirl")
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                let storageRef = self.storage.reference(withPath: "imagesGirl")
                storageRef.putData(imageData, metadata: metadata) {
                    (metadata, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    storageRef.downloadURL(completion: {(url, error) in })
                    self.uploadSuccess(storageRef, storagePath: "imagesGirl")
                }
        }
        let entity = Entity(context: AppDelegate.context)
        entity.imageBoy = photoImageBoy.image
        entity.imageGirl = photoImageGirl.image
        AppDelegate.saveContext()
        dismiss(animated: true, completion: nil)
    }
    func uploadSuccess(_ storageRef: StorageReference, storagePath: String) {
        print("Upload Succeeded!")
        storageRef.downloadURL { (url, error) in
            if let error = error {
                print("Error getting download URL: \(error)")
                return
            }
        }
    }
    
    func senData(name: String) {
        dateLabel.text = name + "Days"

        let key = refArtistis?.childByAutoId().key
        let artist = ["id": key,
                      "dateLove": dateLabel.text
        ]
        refArtistis?.child(key!).setValue(artist)
    }
    
    private func saveInfor() {
        let isSuccesfulSave = NSKeyedArchiver.archiveRootObject(infor!, toFile: Infor.ArchiveURL.path)
        if isSuccesfulSave {
             os_log("Infor successfully saved ", log: OSLog.default, type: .debug)
        } else {
             os_log("Failed to save infor...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadInfor() -> Infor? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Infor.ArchiveURL.path) as? Infor
    }
}
