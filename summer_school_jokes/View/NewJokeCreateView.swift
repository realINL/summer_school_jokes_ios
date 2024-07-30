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
    @State private var selectedTags: [Category] = []
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var networkManager = NetworkManager()
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
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
                
                Text("Tags")
                    .font(.headline)
                    .padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Category.allCases, id: \.self) { category in
                            CategoryButton(category: category, isSelected: selectedTags.contains(category)) {
                                if selectedTags.contains(category) {
                                    selectedTags.removeAll { $0 == category }
                                } else {
                                    selectedTags.append(category)
                                }
                            }
                        }
                    }
                }
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
        guard !title.isEmpty, !text.isEmpty, !selectedTags.isEmpty else {
            showAlert = true
            return
        }
        
        let tags = selectedTags.map { $0.rawValue }
        
        let joke = Joke(title: title, text: text, tags: tags.joined(separator: ", "))
        
        Task {
            await networkManager.createJoke(joke)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct CategoryButton: View {
    var category: Category
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category.rawValue)
                .font(.body)
                .padding()
//                .frame(minWidth: 100)
                .background(isSelected ? Color.gray : Color(.systemGray6))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct NewJokeCreateView_Previews: PreviewProvider {
    static var previews: some View {
        NewJokeCreateView()
    }
}
