//
//  QuizProgressDelegate.swift
//  QuizApp
//
//  Created by Rajat Sachdeva on 2024-11-14.
//

import Foundation

protocol QuizProgressDelegate: AnyObject {
    func didFinishQuiz(with score: Int, totalQuestions: Int)
}
