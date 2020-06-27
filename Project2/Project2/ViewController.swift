//
//  ViewController.swift
//  Project2
//
//  Created by Volodymyr Ostapyshyn on 07.05.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    let defaults = UserDefaults.standard
    
    var countries = [String]()
    var correctAnswer = 0
    var score: Int = 0 {
        didSet {
            if score > highestScore {
                highestScore = score
                defaults.set(highestScore, forKey: "highestScore")
                showNewRecord()
            }
        }
    }
    var highestScore = 0
    var question = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highestScore = defaults.integer(forKey: "highestScore")
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        setBorderImage()
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased() + " Score: \(score) Record: \(highestScore)"
    }
    
    fileprivate func setBorderImage() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        question += 1
        print(question)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: [],
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8,
                                                 y: 0.8)
        }) { _ in
            sender.transform = .identity
            
            if self.question == 10 {
                //score = 0
                let ac = UIAlertController(title: "Result:", message: "Your final score is \(self.score).", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                self.question = 0
                
                self.present(ac, animated: true)
            }
            
        }
        
        
        
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        
        
        if sender.tag != correctAnswer {
            let ac = UIAlertController(title: "Wrong!", message: "That’s the flag of \(sender.currentImage?.accessibilityIdentifier?.uppercased() ?? "0").", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @objc func shareTapped() {
        let shareScore = "Your score is \(score)" //show and share
        
        let vc = UIActivityViewController(activityItems: [shareScore, " Plese share with your friends."], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func showNewRecord() {
        let ac = UIAlertController(title: "RECORD!", message: "New Record is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}

