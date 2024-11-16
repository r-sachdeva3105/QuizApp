//
//  QuizView.swift
//  QuizApp
//
//  Created by Rajat Sachdeva on 2024-11-14.
//

import UIKit

class QuizView: UIViewController {

    @IBOutlet weak var radioButton1: UIButton!
    @IBOutlet weak var radioButton2: UIButton!
    @IBOutlet weak var radioButton3: UIButton!
    @IBOutlet weak var radioButton4: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var noQuestionsLabel: UILabel!
    
    var currentQuestionIndex = 0
    var score = 0
    var selectedAnswer: String?
    
    var currentQuestion: Question? {
        return QuestionBank.questions[currentQuestionIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if QuestionBank.questions.isEmpty {
            showNoQuestionsMessage()
        } else {
            loadNextQuestion()
        }
    }
    
    func showNoQuestionsMessage() {
        questionLabel.isHidden = true
        radioButton1.isHidden = true
        radioButton2.isHidden = true
        radioButton3.isHidden = true
        radioButton4.isHidden = true
        submitButton.isHidden = true
        previousButton.isHidden = true
        nextButton.isHidden = true
        
        noQuestionsLabel.isHidden = false
        noQuestionsLabel.text = "Please add questions first"
    }
    
    func loadNextQuestion() {
        guard let question = currentQuestion else { return }
        
        questionLabel.text = question.questionText
        
        let answers = question.allAnswers.shuffled()
        radioButton1.setTitle(answers[0], for: .normal)
        radioButton2.setTitle(answers[1], for: .normal)
        radioButton3.setTitle(answers[2], for: .normal)
        radioButton4.setTitle(answers[3], for: .normal)
        
        setRadioButtonState(radioButton1, isSelected: false)
        setRadioButtonState(radioButton2, isSelected: false)
        setRadioButtonState(radioButton3, isSelected: false)
        setRadioButtonState(radioButton4, isSelected: false)
        
        progressBar.progress = Float(currentQuestionIndex) / Float(QuestionBank.questions.count)
        
        updateButtonStates()
    }
    
    func updateButtonStates() {
        previousButton.isEnabled = currentQuestionIndex > 0
        nextButton.isEnabled = currentQuestionIndex < QuestionBank.questions.count - 1
        submitButton.isEnabled = currentQuestionIndex == QuestionBank.questions.count - 1
        submitButton.isHidden = nextButton.isEnabled
    }

    @IBAction func radioButtonTapped(_ sender: UIButton) {
        setRadioButtonState(radioButton1, isSelected: false)
        setRadioButtonState(radioButton2, isSelected: false)
        setRadioButtonState(radioButton3, isSelected: false)
        setRadioButtonState(radioButton4, isSelected: false)
        
        setRadioButtonState(sender, isSelected: true)
        
        selectedAnswer = sender.title(for: .normal)
    }
    
    func setRadioButtonState(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            button.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if let selectedAnswer = selectedAnswer {
            guard let question = currentQuestion else { return }
            
            if selectedAnswer == question.correctAnswer {
                score += 1
            }
        }
        
        performSegue(withIdentifier: "ShowResult", sender: self)
    }

    @IBAction func previousButtonTapped(_ sender: UIButton) {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            loadNextQuestion()
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let selectedAnswer = selectedAnswer else {
            return
        }

        guard let question = currentQuestion else { return }
        
        if selectedAnswer == question.correctAnswer {
            score += 1
        }

        self.selectedAnswer = ""
        
        currentQuestionIndex += 1
        
        if currentQuestionIndex < QuestionBank.questions.count {
            loadNextQuestion()
        } else {
            updateButtonStates()
        }
    }
    
    // MARK: - Navigation (Prepare for Segue)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResult" {
            if let resultVC = segue.destination as? QuizResultView {
                resultVC.result = QuizResultModel(score: score, totalQuestions: QuestionBank.questions.count)
            }
        }
    }
}

