//
//  QuestionBankDelegate.swift
//  QuizApp
//
//  Created by Rajat Sachdeva on 2024-11-14.
//

import Foundation

protocol QuestionBankDelegate : AnyObject {
    func didAddNewQuestion(_ question: Question)
    func didUpdateQuestion(_ question: Question, at index: Int)
}
