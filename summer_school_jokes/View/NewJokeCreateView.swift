//
//  NewJokeCreateView.swift
//  summer_school_jokes
//
//  Created by admin on 19.07.2024.
//

import SwiftUI

struct NewJokeCreateView: View {
        @State private var title: String = ""
        @State private var text: String = ""
        @State private var tags: String = ""
        @State private var showAlert = false
        @Environment(\.presentationMode) var presentationMode
        
        @StateObject private var networkManager = NetworkManager()
        
        var body: some View {
            NavigationView {
                VStack {
                    TextField("Title", text: $title)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    TextField("Text", text: $text)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    TextField("Tags (comma separated)", text: $tags)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        Button(action: {
                            submitJoke()
                        }) {
                            Text("Submit")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                .navigationTitle("New Joke")
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Please fill in all fields"), dismissButton: .default(Text("OK")))
                }
            }
        }
        
        private func submitJoke() {
            guard !title.isEmpty, !text.isEmpty, !tags.isEmpty else {
                showAlert = true
                return
            }
            
            let tagsArray = tags.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
            
            let joke = Joke(title: title, text: text, tags: tags)
            
            Task {
                await networkManager.createJoke(joke)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
}

struct NewJokeCreateView_Previews: PreviewProvider {
    static var previews: some View {
        NewJokeCreateView()
    }
}
