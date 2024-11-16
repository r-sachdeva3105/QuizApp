//
//  QuizResultView.swift
//  QuizApp
//
//  Created by Rajat Sachdeva on 2024-11-14.
//

import UIKit

class QuizResultView: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var result: QuizResultModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let result = result {
            resultLabel.text = "\(result.score) / \(result.totalQuestions)"
        }
    }
}

