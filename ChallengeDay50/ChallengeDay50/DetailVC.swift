//
//  DetalVC.swift
//  ChallengeDay50
//
//  Created by Volodymyr Ostapyshyn on 11.06.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//


import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet var pictureImage: UIImageView!
    var selectedImage: Picture?
    var table: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(renamePhoto))
        
        guard let selectedImage = selectedImage else {
            print("No Image")
            return
        }
        
        
        
        
        let path = getDocumentsDirectory().appendingPathComponent(selectedImage.name)
        
        pictureImage.image = UIImage(contentsOfFile: path.path)
        
        
        
        
        title = selectedImage.caption
        
        //navigationItem.largeTitleDisplayMode = .never
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @objc func renamePhoto() {
            
            let ac = UIAlertController(title: "Rename Photo", message: nil, preferredStyle: .alert)
            
            let renameAction = UIAlertAction(title: "Rename",
                                             style: .default) { [weak self] _ in
                self?.changeName()
            }
              
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .cancel)
            ac.addAction(cancelAction)
                    
            ac.addAction(renameAction)

            present(ac, animated: true)

        }
    
    func changeName() {
        //let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename picture", message: nil, preferredStyle: .alert)
        
        ac.addTextField() { textField in
            //textField.text = person.name == "Unknown" ? "" : person.name
            textField.placeholder = "Picture's Name"
        }

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            self!.selectedImage?.caption = newName
            self!.table?.reloadData()
            self!.title = newName

            //self?.table.reloadData()
        })

        present(ac, animated: true)
    }
}
