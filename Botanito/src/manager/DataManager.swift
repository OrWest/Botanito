//
//  DataManager.swift
//  Botanito
//
//  Created by Alex Motor on 17.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class DataManager: NSObject {
    private let dataBase: FIRDatabase!
    private let storage: FIRStorage!
    var families: [Family] = []
    var familiesLoaded: Bool = false
    
    override init() {
        dataBase = FIRDatabase.database()
        storage = FIRStorage.storage()
        super.init()
        
        dataBase.persistenceEnabled = true
    }
    
    func fillDataBase(completion: @escaping () -> ()) {
        loadFamilies(completion: completion)
    }
    
    func prepareChallenge(challengeType: ChallengeType) -> [FormulaQuestion] {
        var questions: [FormulaQuestion] = []
        
        for family in families {
            var families = self.families
            families.remove(at: families.index(of: family)!)
            
            let text = "Семейство \(family.name)"
            var answers: [UIImage] = []
            for _ in 0...2 {
                let randomInt = Int(arc4random_uniform(UInt32(families.count)))
                let answerImage = self.families[randomInt].image!
                answers.append(answerImage)
            }
            let correctAnswerIndex = Int(arc4random_uniform(4))
            answers.insert(family.image!, at: correctAnswerIndex)
            
            let question = FormulaQuestion(text: text, answers: answers, correctIndex: correctAnswerIndex)
            questions.append(question)
        }
        
        return questions
    }
    
    // MARK: - Private
    
    private func loadFamilies(completion: @escaping () -> ()) {
        dataBase.reference().child("families").observe(.value, with: { [weak self] snapshot in
            guard self != nil else {
                return
            }
            for familyModel in snapshot.children {
                let snap = familyModel as! FIRDataSnapshot
                let family = Family(snap: snap,storageRef: self!.storage.reference(withPath: "Formula"))
                self!.families.append(family)
            }
            
            self!.familiesLoaded = true
            completion()
        })
    }
}
