//
//  ViewController.swift
//  ChallengeDay23
//
//  Created by Volodymyr Ostapyshyn on 11.05.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flags Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        
        for item in items {
            if item.contains("2x") {
                flags.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Details") as? DetailVC {
            // 2: success! Set its selectedImage property
            
            name = getCountry(row: indexPath)
            vc.selectedImage = flags[indexPath.row]
            vc.name = name
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        
        // how to add spacing between cells?
        cell.textLabel?.text = getCountry(row: indexPath)
        
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        //cell.backgroundColor = UIColor.gray
        return cell
    }
    
    func getCountry(row: IndexPath ) -> String {
        let oldName = flags[row.row]
        let index = oldName.firstIndex(of: "@")!
        let countryName = oldName[oldName.startIndex..<index]
        
        return countryName.count > 2 ? countryName.capitalized : countryName.uppercased()
    }
    
}


