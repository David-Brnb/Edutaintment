//
//  GameLogic.swift
//  Edutaintment
//
//  Created by Leoni Bernabe on 03/01/25.
//

import SwiftUI

class GameLogic: ObservableObject {
    @Published var table = 2.0
    @Published var questions = 10
    @Published var score = 0
    @Published var answered = 0
    @Published var answer = ""
    @Published var submitted = false
    @Published var currentQuestionIndex = 0

    let range = 2.0...12.0
    let questionsSet = [5, 10, 20]
    private var multiples: [Int] = []

    var currentQuestionText: String {
        let multiplier = multiples[currentQuestionIndex]
        return "\(multiplier) x \(Int(table))"
    }

    func startGame() {
        multiples = (1...questions).map { _ in Int.random(in: 2...10) }
        score = 0
        answered = 0
        answer = ""
        submitted = false
        currentQuestionIndex = 0
    }

    func resetGame() {
        table = 2.0
        questions = 10
        score = 0
        answered = 0
        answer = ""
        submitted = false
        currentQuestionIndex = 0
        multiples.removeAll()
    }

    func submitAnswer() {
        submitted = true
        if let userAnswer = Int(answer), userAnswer == correctAnswer() {
            score += 1
        }
    }

    func nextQuestion() {
        if answered < questions - 1 {
            currentQuestionIndex += 1
            submitted = false
        }
        answer = ""
        answered += 1
    }

    func checkAnswer() -> Bool {
        guard let userAnswer = Int(answer) else { return false }
        return userAnswer == correctAnswer()
    }

    private func correctAnswer() -> Int {
        return multiples[currentQuestionIndex] * Int(table)
    }
}

