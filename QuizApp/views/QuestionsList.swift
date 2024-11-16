//
//  QuestionsList.swift
//  QuizApp
//
//  Created by Rajat Sachdeva on 2024-11-14.
//

import UIKit

class QuestionsList: UITableViewController, QuestionBankDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didAddNewQuestion(_ question: Question) {
        tableView.reloadData()
    }

    func didUpdateQuestion(_ question: Question, at index: Int) {
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionBank.questions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let question = QuestionBank.questions[indexPath.row]
        cell.textLabel?.text = question.questionText
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let question = QuestionBank.questions[indexPath.row]
        performSegue(withIdentifier: "ShowQuestionBuilder", sender: question)
    }
    

    /*
    // MARK: - Navigation
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let questionBuilderVC = segue.destination as? QuestionBuilder {
                if let question = sender as? Question {
                    questionBuilderVC.existingQuestion = question
                    questionBuilderVC.questionIndex = tableView.indexPathForSelectedRow?.row
                }
                questionBuilderVC.delegate = self
            }
        }

}
