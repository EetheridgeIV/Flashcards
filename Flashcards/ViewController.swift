//
//  ViewController.swift
//  Flashcards
//
//  Created by Eddie Etheridge on 10/20/18.
//  Copyright © 2018 Eddie Etheridge. All rights reserved.
//

import UIKit

struct Flashcard {
    var question : String
    var answer : String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    //Current Flashcard Index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Read saved flashcards
        readSavedFlashcards()
        
        //Adding our initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = true;
    }
    
    func updateNextPrevButtons(){
        
        //Disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        //Disable prev button if at beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateFlashcard(question: String, answer: String){
        let flashcard = Flashcard(question: question, answer: answer)
        
        //Adding flashcard to flashcards array
        flashcards.append(flashcard)
        
        //Logging to console
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        //Update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        // Update buttons
        updateNextPrevButtons()
        
        //Update labels
        updateLabels()
        
        //Save to disk
        saveAllFlashcardsToDisk()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
    
        //Increase current index
        currentIndex = currentIndex + 1
        
        //Update labels
        updateLabels()
        
        //Update Buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
    
        //Decrease current index
        currentIndex = currentIndex - 1
        
        //Update labels
        updateLabels()
        
        //Update Buttons
        updateNextPrevButtons()
    }
    
    func updateLabels() {
        
        //Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //Update Labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
    }
    
    func saveAllFlashcardsToDisk() {
        
        // from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        //Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        //Log it
        print("Flashcards saved to User Defaults")
        
    }
    
    func readSavedFlashcards() {
        
        //Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            
            //In here we know we have a dictionary array
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // Put all these cards in our flashcards Array
            flashcards.append(contentsOf: savedCards)
        }
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

