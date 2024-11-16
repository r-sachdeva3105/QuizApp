//
//  QuestionModel.swift
//  QuizApp
//
//  Created by Rajat Sachdeva on 2024-11-14.
//

import Foundation

struct Question {
    let questionText : String
    let correctAnswer : String
    let incorrectAnswers : [String]
    
    var allAnswers : [String] {
        return [correctAnswer] + incorrectAnswers
    }
}
