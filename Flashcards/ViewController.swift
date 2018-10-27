//
//  ViewController.swift
//  Flashcards
//
//  Created by Eddie Etheridge on 10/20/18.
//  Copyright © 2018 Eddie Etheridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = true;
    }
    
    func updateFlashcard(question: String, answer: String){
        frontLabel.text = question;
        backLabel.text = answer;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Setting the destination of the Segue to be the navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        //We know the navigation controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        //Setting flashcardController's property to self
        creationController.flashcardsController = self
    }
    
}

