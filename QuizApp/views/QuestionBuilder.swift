//
//  QuestionBuilder.swift
//  QuizApp
//
//  Created by Rajat Sachdeva on 2024-11-14.
//

import UIKit

class QuestionBuilder: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var incorrectAnswerTextField1: UITextField!
    @IBOutlet weak var incorrectAnswerTextField2: UITextField!
    @IBOutlet weak var incorrectAnswerTextField3: UITextField!

    var existingQuestion: Question?
    var questionIndex: Int?
    
    weak var delegate: QuestionBankDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let question = existingQuestion {
            questionTextField.text = question.questionText
            correctAnswerTextField.text = question.correctAnswer
            incorrectAnswerTextField1.text = question.incorrectAnswers[0]
            incorrectAnswerTextField2.text = question.incorrectAnswers[1]
            incorrectAnswerTextField3.text = question.incorrectAnswers[2]
        }
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func saveButton(_ sender: Any) {
        guard let questionText = questionTextField.text, !questionText.isEmpty,
              let correctAnswer = correctAnswerTextField.text, !correctAnswer.isEmpty,
              let incorrectAnswer1 = incorrectAnswerTextField1.text, !incorrectAnswer1.isEmpty,
              let incorrectAnswer2 = incorrectAnswerTextField2.text, !incorrectAnswer2.isEmpty,
              let incorrectAnswer3 = incorrectAnswerTextField3.text, !incorrectAnswer3.isEmpty else {
            return
        }
        
        let newQuestion = Question(questionText: questionText, correctAnswer: correctAnswer, incorrectAnswers: [incorrectAnswer1, incorrectAnswer2, incorrectAnswer3])
        
        if let index = questionIndex {
            QuestionBank.updateQuestion(at: index, with: newQuestion)
            delegate?.didUpdateQuestion(newQuestion, at: index)
        } else {
            QuestionBank.addQuestion(newQuestion)
            delegate?.didAddNewQuestion(newQuestion)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
