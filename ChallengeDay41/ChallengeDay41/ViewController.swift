//
//  ViewController.swift
//  ChallengeDay41
//
//  Created by Volodymyr Ostapyshyn on 23.05.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var letterButtons = [UIButton]()
    var currentAnswer: UITextField!
    var submit: UIButton!
    var buttonsView: UIView!
    var guessesRemaining: UILabel!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevel()
    }
    
    func configureGuessesRemaining() {
        guessesRemaining = UILabel()
        guessesRemaining.translatesAutoresizingMaskIntoConstraints = false
        guessesRemaining.textAlignment = .center
        guessesRemaining.text = "Guesses Remaining: 7"
        guessesRemaining.font = UIFont.systemFont(ofSize: 48)
        view.addSubview(guessesRemaining)
        
        NSLayoutConstraint.activate([
            guessesRemaining.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 24),
            guessesRemaining.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func configureUI() {
        configureButtonsView()
        configureSubmitButton()
        configureClearButton()
        configureCurrentAnswer()
        configureGuessesRemaining()
    }
    
    func configureCurrentAnswer() {
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap one letter to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 36)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        NSLayoutConstraint.activate([
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.bottomAnchor.constraint(equalTo: submit.topAnchor, constant: -20)
        ])
    }
    
    func loadLevel() {
        
        let str = "abcdefghijklmnopqrstuvwxyz"
        let letters = Array(str.uppercased())
        print(letters.count)
        print(letterButtons.count)
        
        
        for i in 0 ..< letterButtons.count {
            self.letterButtons[i].setTitle(letters[i].description, for: .normal)
        }
        
        
    }
    
    func configureClearButton() {
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        //clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        clear.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(clear)
        
        NSLayoutConstraint.activate([
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.bottomAnchor.constraint(equalTo: buttonsView.topAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureSubmitButton() {
        submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        
        //submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        NSLayoutConstraint.activate([
            submit.bottomAnchor.constraint(equalTo: buttonsView.topAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureButtonsView() {
        buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.cornerRadius = 12
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        
        NSLayoutConstraint.activate([
            buttonsView.widthAnchor.constraint(equalToConstant: 600),
            buttonsView.heightAnchor.constraint(equalToConstant: 400),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        let width = 100
        let height = 80
        
        for row in 0..<5 {
            for col in 0..<6 {
                // create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                // give the button some temporary text so we can see it on-screen
                letterButton.setTitle("A", for: .normal)
                
                if row == 4, col == 0 {
                    let frame = CGRect(x: 2 * width, y: 4 * height, width: width, height: height)
                    letterButton.frame = frame
                } else if row == 4, col == 1 {
                    let frame = CGRect(x: 3 * width, y: 4 * height, width: width, height: height)
                    letterButton.frame = frame
                } else {
                    let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                    letterButton.frame = frame
                }
                
                
                if letterButtons.count < 26 {
                    letterButtons.append(letterButton)
                    buttonsView.addSubview(letterButton)
                }
                
                //letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
    }
    
    
    
    
}

