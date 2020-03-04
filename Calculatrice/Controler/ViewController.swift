//
//  ViewController.swift
//  Calculatrice
//
//  Created by rochdi ben abdeljelil on 20.02.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK - Outlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calcul = Calculator()
    
    //MARK: -ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateText), name: Notification.Name("updateCalcul"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayError(_:)), name: Notification.Name("error"), object: nil)
        // Do any additional setup after loading the view.
    }
    //MARK: - Action Number
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calcul.addNumber(numberText)
    }
    
    //MARK: - Operations
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calcul.addOperations("+")
    }
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calcul.addOperations("-")
    }
    @IBAction func tappedDivideButton(_ sender: UIButton) {
        calcul.addOperations("/")
    }
    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        calcul.addOperations("*")
    }
    @IBAction func tappedDotButton(_ sender: UIButton) {
        calcul.addNumber(".")
    }
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calcul.equal()
    }
    @IBAction func tappedClearButton(_ sender: UIButton) {
        calcul.clearNumber()
    }
    @objc func updateText() {
        textView.text = calcul.numberOnScreen
    }
    //MARK: - Alert Message
    
       func alert(_ message: String) {
           let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
           alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           present(alertVC, animated: true, completion: nil)
       }
    @objc func displayError(_ notif: Notification) {
        if let message = notif.userInfo?["message"] as? String {
            alert(message)
        } else {
            alert("Erreur Inconnue")
        }
    }
}
