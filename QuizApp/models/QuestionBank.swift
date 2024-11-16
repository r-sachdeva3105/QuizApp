//
//  QuestionBank.swift
//  QuizApp
//
//  Created by Rajat Sachdeva on 2024-11-14.
//

import Foundation

class QuestionBank {
    
    static var questions: [Question] = []
    
    static func addQuestion(_ question: Question) {
        questions.append(question)
    }
    
    static func updateQuestion(at index: Int, with newQuestion: Question) {
        questions[index] = newQuestion
    }
    
    static func deleteQuestion(at index: Int) {
        questions.remove(at: index)
    }
    
}
