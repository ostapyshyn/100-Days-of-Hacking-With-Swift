//
//  ViewController.swift
//  Project7
//
//  Created by Volodymyr Ostapyshyn on 16.05.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Petitions"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(info))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter))
        
        
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                filteredPetitions = petitions
                return
            }
        }
        
        showError()
        
    }
    
    @objc func info() {
        let ac = UIAlertController(title: "About", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filter() {
        let ac = UIAlertController(title: "Filter:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer: answer)
        }
        
        let showAll = UIAlertAction(title: "Show all", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.showAll(answer: answer)
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(submitAction)
        ac.addAction(showAll)
        present(ac, animated: true)
    }
    
    func submit(answer: String) {
        //Day 40 -> challenge 3, put your filtering code in the background
        DispatchQueue.global().async {
            self.filteredPetitions = []
            
            self.filteredPetitions = self.petitions.filter({ petition -> Bool in
                return petition.title.contains(answer)
            })
            //        for petition in petitions {
            //            if petition.title.contains(answer) {
            //                filtredPetitions.append(petition)
            //            }
            //        }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func showAll(answer: String) {
        filteredPetitions = petitions
        tableView.reloadData()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

