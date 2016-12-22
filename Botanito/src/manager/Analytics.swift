//
//  Analytics.swift
//  Botanito
//
//  Created by Alex Motor on 23.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit
import Firebase

class Analytics: NSObject {
    static func AppLaunched() {
        FIRAnalytics.logEvent(withName: "app_launched", parameters: nil)
    }
    static func StartChallenge(challenge: Challenge) {
        FIRAnalytics.logEvent(withName: "challenge_started", parameters: [
            "challenge_type" : challenge.challengeType.rawValue as NSObject
            ])
    }
    static func EndChallenge(challenge: Challenge) {
        FIRAnalytics.logEvent(withName: "challenge_ended", parameters: [
            "challenge_type" : challenge.challengeType.rawValue as NSObject,
            "correct_percentage" : challenge.correctAnsweredInPrecent as NSObject,
            "correct_answered" : challenge.correctAnswered as NSObject,
            "answered_count" : challenge.answeredCount as NSObject
            ])
    }
    static func answer(question: FormulaQuestion, answerIndex: Int) {
        let correctString = question.correctAnswerIndex == answerIndex ? "yes" : "no"
        FIRAnalytics.logEvent(withName: "answer", parameters: [
            "text" : question.text as NSObject,
            "answer_correct" : correctString as NSObject
            ])
    }
}
