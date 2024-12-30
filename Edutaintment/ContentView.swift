//
//  ContentView.swift
//  Edutaintment
//
//  Created by Leoni Bernabe on 28/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var play=false
    @State private var table = 2.0
    @State private var multiples_1: [Int] = [];
    let range = 2.0...12.0
    @State private var questions = 10
    let questionsSet = [5, 10, 20]
    @State private var score = 0
    @State private var answered = 0
    @State private var answer = ""
    @State private var submited = false
    @State private var it = 0
    
    
    var body: some View {
        NavigationView {
            VStack{
                Form{
                    if !play {
                        Section("Table"){
                            Stepper (
                                value: $table,
                                in: range,
                                step: 1
                            ) {
                                Text("Table:  \(String(format: "%.0f", table))")
                            }
                            .font(.largeTitle)
                            
                        }
                        
                        Section("Pick the number of questions"){
                            Picker("Tip percentage", selection: $questions){
                                ForEach(questionsSet, id: \.self) {
                                    Text($0, format: .number)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        
                        
                    } else {
                        if(answered < questions){
                            let res = Int(answer.filter { $0.isNumber }) ?? 0
                            let mult = multiples_1[it]
                            
                            Section("Question"){
                                Text("\(mult) x \(String(format: "%.0f", table))")
                                    .frame(width: 300)
                                    .font(.largeTitle)
                            }
                            
                            Section("Enter your answer"){
                                
                                TextField("Answer", text: $answer)
                                    .keyboardType(.numberPad)
                                    .font(.largeTitle)
                                    .multilineTextAlignment(.center)
                                    .onSubmit{
                                        submited.toggle()
                                        if(res == mult*Int(table)){
                                            score+=1
                                        }
                                    }
                                
                            }
                            
                            if submited {
                                Section ("Result") {
                                    let result = (res == mult*Int(table))
                                    Text(result ? "Correct" : "Incorrect")
                                    
                                    Button("Next"){
                                        submited = false
                                        answer = ""
                                        it+=1
                                        answered += 1
                                    }
                                }
                            }
                            
                        } else {
                            Text("Your Score is: \(score) out of \(questions)")
                        }
                        
                    }
                }
                
                
            }
            .toolbar{
                if play {
                    Text("Progress: \(answered) / \(questions)")
                }
                Button(play ? "Configure" : "Play"){
                    if(play){
                        resetGame()
                        
                    } else {
                        startGame()
                        
                    }
                    play.toggle()
                }
            }
            .navigationBarTitleDisplayMode(.automatic)
            
        }
    }
    
    func resetGame() {
        multiples_1.removeAll()
        table = 2
        questions = 10
    }
    
    func startGame() {
        for _ in (1...questions){
            multiples_1.append(Int.random(in: 2...10))
        }
        score = 0
        answered = 0
        answer = ""
    }
}

#Preview {
    ContentView()
}
