//
//  DetailVC.swift
//  ChallengeDay23
//
//  Created by Volodymyr Ostapyshyn on 11.05.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet var image: UIImageView!
    var selectedImage: String?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        guard let selectedImage = selectedImage else { return }
        
        navigationItem.largeTitleDisplayMode = .never
        
        title = name
                
        image.backgroundColor = UIColor.darkGray
        image.image = UIImage(named: selectedImage)

    }
    
    @objc func shareTapped() {
        guard let image = image.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let index = selectedImage!.firstIndex(of: "@")!
        let country = selectedImage![selectedImage!.startIndex..<index].uppercased()
       
        let vc = UIActivityViewController(activityItems: [image, country], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
