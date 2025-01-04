//
//  ContentView.swift
//  Edutaintment
//
//  Created by Leoni Bernabe on 28/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var play=false
    @StateObject private var gameLogic = GameLogic()
    
    
    var body: some View {
        NavigationView {
            VStack{
                Form{
                    if !play {
                        Section("Table"){
                            Stepper (
                                value: $gameLogic.table,
                                in: gameLogic.range,
                                step: 1
                            ) {
                                Text("Table:  \(String(format: "%.0f", gameLogic.table))")
                            }
                            .font(.largeTitle)
                            
                        }
                        
                        Section("Pick the number of questions"){
                            Picker("Tip percentage", selection: $gameLogic.questions){
                                ForEach(gameLogic.questionsSet, id: \.self) {
                                    Text($0, format: .number)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        
                        
                    } else {
                        if(gameLogic.answered < gameLogic.questions){
                            let currentQuestion = gameLogic.currentQuestionText
                            
                            Section("Question"){
                                Text(currentQuestion)
                                    .frame(width: 300)
                                    .font(.largeTitle)
                            }
                            
                            Section("Enter your answer"){
                                
                                TextField("Answer", text: $gameLogic.answer)
                                    .keyboardType(.numberPad)
                                    .font(.largeTitle)
                                    .multilineTextAlignment(.center)
                                    .onSubmit { gameLogic.submitAnswer() }
                                
                            }
                            
                            if gameLogic.submitted {
                                Section ("Result") {
                                    let isCorrect = gameLogic.checkAnswer()
                                    Text(isCorrect ? "Correct" : "Incorrect")
                                    
                                    Button("Next"){
                                        gameLogic.nextQuestion()
                                    }
                                }
                            }
                            
                        } else {
                            Section("Game Over") {
                                Text("Your Score is: \(gameLogic.score) out of \(gameLogic.questions)")
                                Button("Play Again") {
                                    gameLogic.resetGame()
                                    play = false
                                }
                            }
                        }
                        
                    }
                }
                
                
            }
            .toolbar{
                if play {
                    Text("Progress: \(gameLogic.answered) / \(gameLogic.questions)")
                }
                Button(play ? "Configure" : "Play"){
                    if(play){
                        gameLogic.resetGame()
                        
                    } else {
                        gameLogic.startGame()
                        
                    }
                    play.toggle()
                }
            }
            .navigationBarTitleDisplayMode(.automatic)
            
        }
    }
    
}

#Preview {
    ContentView()
}
