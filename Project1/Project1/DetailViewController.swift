//
//  DetailViewController.swift
//  Project1
//
//  Created by Volodymyr Ostapyshyn on 01.04.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var pictures: [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pictures = pictures,
            let selectedImage = selectedImage else { return }
        
        let totalNumberOfPictures = pictures.count
        
        let firstIndex = pictures.firstIndex(of: selectedImage)
        
        guard let theFirstIndex = firstIndex else { return }
        
        let numberInArray = Int(theFirstIndex)
        
        title = "Picture \(numberInArray + 1) of \(totalNumberOfPictures)"
        
        navigationItem.largeTitleDisplayMode = .never
        
        imageView.image  = UIImage(named: selectedImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
