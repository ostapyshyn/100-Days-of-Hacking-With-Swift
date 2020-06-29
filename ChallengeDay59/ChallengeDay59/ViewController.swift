//
//  ViewController.swift
//  ChallengeDay59
//
//  Created by Volodymyr Ostapyshyn on 28.06.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Country facts:"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath) as! CountryCell
        
        
        let country = countries[indexPath.row]
        
        cell.flagImage.image = UIImage(named: getFlagFileName(code: country.alpha2Code, type: .SD))
        cell.flagImage?.layer.borderColor = UIColor.black.cgColor
        cell.flagImage?.layer.borderWidth = 0.1
        cell.flagImage?.layer.cornerRadius = 5
        cell.countryLabel.text = country.name
        cell.capitalLabel.text = country.capital
        
        
        
        return cell
    }
    
    @objc func fetchJSON() {
        
        let urlString = "https://restcountries.eu/rest/v2/all?fields=name;alpha2Code;capital;population;demonym;area;nativeName;currencies;languages;flag"
        
        if let url = URL(string: urlString) {
            
            do {
                let data = try Data(contentsOf: url)
                let jsonCountries = try JSONDecoder().decode([Country].self, from: data)
                countries = jsonCountries
            }
                
            catch let error {
                print("Data or JSONDecoder error: \(error)")
                performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
            }
            
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }
    }
    
    
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
}

