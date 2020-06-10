//
//  ViewController.swift
//  Project1
//
//  Created by Volodymyr Ostapyshyn on 31.03.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let defaults = UserDefaults.standard

    var pictures = [String]()
    var timesShown = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(fetchPics), with: nil)
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
        
        
        //let sortedPics = pictures.sorted()
        print(pictures.sorted())
        timesShown = defaults.object(forKey: "SavedArray") as? [Int] ?? [Int]()
        
    }
    
    @objc func fetchPics() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
        print("Finished loading pictures")
        
        timesShown = Array(repeating: 0, count: pictures.count)
        print("\(timesShown.count) times shown")
        print(timesShown)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.pictures = pictures
            timesShown[indexPath.row] += 1
            defaults.set(timesShown, forKey: "SavedArray")
            tableView.reloadData()
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
    
        cell.detailTextLabel?.text = "Shown \(timesShown[indexPath.row])"
        
        return cell
    }
    
    @objc func shareTapped() {
        
        let recomendation = "I recomend this app: StormViewer"
        
        let vc = UIActivityViewController(activityItems: [recomendation], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

