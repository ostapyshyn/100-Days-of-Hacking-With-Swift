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
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedImage = selectedImage else {
            print("No Image")
            return
        }
        
        pictureImage.image = selectedImage
        
        
        //title = "Picture"
        
        //navigationItem.largeTitleDisplayMode = .never
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
