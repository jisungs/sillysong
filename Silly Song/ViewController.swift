//
//  ViewController.swift
//  Silly Song
//
//  Created by The book on 2018. 1. 29..
//  Copyright © 2018년 The book. All rights reserved.
//

import UIKit

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"
    ].joined(separator: "\n")

func shortNameForName(name: String) -> String {
    let lowerCaseName = name.lowercased()
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    let firstVowelRange = lowerCaseName.rangeOfCharacter(from: vowelSet, options: .caseInsensitive)

    if lowerCaseName.rangeOfCharacter(from: vowelSet, options: .caseInsensitive) == nil{
        return lowerCaseName
    }else if lowerCaseName.rangeOfCharacter(from: vowelSet, options: .caseInsensitive) != nil{
        return String(lowerCaseName.suffix(from: firstVowelRange!.lowerBound))
    }
    
    return String(lowerCaseName)
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameForName(name: fullName)
    
    let lyrics = lyricsTemplate
    .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    
    return lyrics
}

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }


    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        self.lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: self.nameField.text!)
    }
    
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) ->Bool{
        textField.resignFirstResponder()
        return false
    }
}
