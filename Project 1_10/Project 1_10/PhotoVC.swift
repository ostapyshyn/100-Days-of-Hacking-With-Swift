//
//  PhotoVC.swift
//  Project 1_10
//
//  Created by Volodymyr Ostapyshyn on 06.06.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {
    
    var image: UIImage?
    
    @IBOutlet var viewImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = "Picture"
        viewImage.image = image
        
        // Do any additional setup after loading the view.
    }
    
}
