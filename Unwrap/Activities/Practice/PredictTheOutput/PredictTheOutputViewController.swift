//
//  PredictTheOutputViewController.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2019 Hacking with Swift.
//

import Sourceful
import UIKit

/// The view controller that handles Predict the Output practice activities.
class PredictTheOutputViewController: UIViewController, Storyboarded, PracticingViewController {
    var coordinator: (Skippable & AnswerHandling)?
    var practiceType = "predict-the-output"

    @IBOutlet var prompt: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var code: UILabel!
    @IBOutlet var answerEntry: UITextField!

    /// The current question they are solving, along with hints and solutions.
    var practiceData: PredictTheOutputPractice!

    /// Set to true when the user has selected an answer.
    var isShowingAnswers = false

    /// Lets us track how far the user is through their current practice/challenge session.
    var questionNumber = 1

    /// Configures the UI with the correct content for our current activity.
    override func viewDidLoad() {
        super.viewDidLoad()

        assert(coordinator != nil, "You must set a coordinator before presenting this view controller.")
        assert(practiceData != nil, "You must assign some practice data before presenting this view controller.")

        title = "Predict the Output" + (coordinator?.titleSuffix(for: self) ?? "")
        navigationItem.largeTitleDisplayMode = .never

        // The prompt can only be simple HTML (e.g. <code></code>), but the source code is fully syntax highlighted.
        prompt.attributedText = practiceData.question.fromSimpleHTML()
        code.attributedText = practiceData.code.syntaxHighlighted()
        code.font = Unwrap.codeFont

        // Make sure our text view stays out of the way of the keyboard rather than scrolling under it.
        scrollView.avoidKeyboard()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skip))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hint", style: .plain, target: self, action: #selector(hint))

        // Attach the Submit button directly to the keyboard to make input faster.
        let submitButton = UIButton.primary(frame: CGRect(x: 0, y: 0, width: 50, height: UIButton.primaryButtonHeight))
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        answerEntry.inputAccessoryView = submitButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // MARZIPAN: Set up macOS navigation bar items
        #if MARZIPAN
        navigationController?.setNavigationBarHidden(true, animated: false)
        Unwrap.marzipanCoordinator?.resetNavigationBar()
        Unwrap.marzipanCoordinator?.setTitle(title!)
        Unwrap.marzipanCoordinator?.setupLeftBarButtonItem(text: "Skip", target: self, action: #selector(skip))
        Unwrap.marzipanCoordinator?.setupRightBarButtonItem(text: "Hint", target: self, action: #selector(hint))
        #endif
    }

    @objc func hint() {
        showAlert(body: practiceData.hint, on: self)
    }

    @objc func skip() {
        coordinator?.skipPracticing()
    }

    /// Check whether the user's answer was correct and either update the UI to reflect their answer or move on.
    @objc func checkAnswer(_ sender: Any) {
        guard let answerButton = answerEntry.inputAccessoryView as? UIButton else {
            fatalError("Missing submit button accessory view.")
        }

        let isUserCorrect = practiceData.answerIsCorrect(answerEntry.text ?? "")

        if isShowingAnswers {
            // We already marked their answer, so tell the coordinator to move on.
            coordinator?.answerSubmitted(from: self, wasCorrect: isUserCorrect)
        } else {
            // They are now just submitting their answer; update the UI to reflect whether they were correct or wrong.
            isShowingAnswers = true

            navigationItem.leftBarButtonItem?.isEnabled = false
            answerButton.setTitle("CONTINUE", for: .normal)

            // MARZIPAN: Set up macOS navigation bar items
            #if MARZIPAN
            Unwrap.marzipanCoordinator?.leftBarButtonItem?.isEnabled = false
            #endif

            if isUserCorrect {
                answerButton.correctAnswer()
            } else {
                answerButton.wrongAnswer()
            }
        }
    }
}
