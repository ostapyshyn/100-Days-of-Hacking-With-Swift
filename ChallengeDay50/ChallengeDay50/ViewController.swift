//
//  ViewController.swift
//  ChallengeDay50
//
//  Created by Volodymyr Ostapyshyn on 10.06.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    var pictures = [Picture]()
    var currentPicture: UIImage?
    var currentPictures = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Photos:"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(addPhoto))
    }
    
    @objc func addPhoto() {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        present(picker, animated: true)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let picture = Picture(name: imageName, caption: "not set")
        
        pictures.append(picture)
        
        let path = getDocumentsDirectory().appendingPathComponent(picture.name)
        print("\(path.path) up")
        
        
        currentPictures.append(UIImage(contentsOfFile: path.path)!)
        
        tableView.reloadData()

        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! CustomCellVC
        
        let picture = pictures[indexPath.item]

        //cell.textLabel?.text = pictures[indexPath.row].caption

        let path = getDocumentsDirectory().appendingPathComponent(picture.name)
        tableView.separatorStyle = .singleLine
        cell.pictureImage?.image = UIImage(contentsOfFile: path.path)
        print("\(path.path) down")
        //cell.imageView?.image = UIImage(contentsOfFile: path.path)
        
//        cell.imageView?.layer.borderWidth = 1
//        cell.imageView?.layer.borderColor = UIColor.black.cgColor
//        cell.layer.cornerRadius = 7

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(112)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            // 2: success! Set its selectedImage property
            
            vc.selectedImage = currentPictures[indexPath.row]
            print("\(indexPath.row) current row")
            //tableView.cellForRow(at: indexPath)?.imageView
            
            tableView.reloadData()
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
            print("\(currentPictures.count) total pictures")
            
        }
    }
}

