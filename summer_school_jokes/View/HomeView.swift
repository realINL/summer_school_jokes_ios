//
//  HomeView.swift
//  summer_school_jokes
//
//  Created by admin on 12.07.2024.
//

import SwiftUI


enum Category: String, CaseIterable {
    case general = "General"
    case technology = "Technology"
    case science = "Science"
    case politics = "Politics"
    case sports = "Sports"
    case animals = "Animals"
    case school = "School"
    case work = "Work"
    case adventure = "Adventure"
}

struct HomeView: View {
    @StateObject private var networkManager = NetworkManager()
    //    @State var jokes: [Joke]
    @State private var selectedCategory: Category? = nil


    
    var body: some View {
        VStack {
            HStack {
                Label("Summer school jokes", systemImage: "book")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
            HStack(spacing: 20) {
                Spacer()
                
                Menu {
                    ForEach(Category.allCases, id: \.self) { category in
                        Button(action: {
                            if selectedCategory == category {
                                selectedCategory = nil
                            } else {
                                selectedCategory = category
                            }
                            networkManager.filterJokes(by: selectedCategory)
                        }) {
                            Label(category.rawValue, systemImage: selectedCategory == category ? "checkmark" : "")
                        }
                    }
                } label: {
                    HStack {
                        Text("Categories")
                        Image(systemName: selectedCategory != nil ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease")
                    }
                    .foregroundColor(.primary)
                    .font(.headline)
                    .padding(.trailing, 20)
                }
                
            }
            //            .padding(.leading, 15)
            ScrollView {
                            LazyVStack {
                                ForEach(networkManager.filteredJokes) { joke in
                                    NewJokeView(joke: joke)
                                }
                            }
                        }
            .onAppear {
                networkManager.fetchJokes()
                networkManager.filterJokes(by: selectedCategory)
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


