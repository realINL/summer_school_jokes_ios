//
//  ProfileView.swift
//  summer_school_jokes
//
//  Created by admin on 12.07.2024.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    @StateObject private var networkManager = NetworkManager()
    @AppStorage("isAuthenticated") var isAuthenticated = false
    @State private var showNewJokeView = false
    @State private var labelText = ""
    @Binding var newJoke: String
    
    var body: some View {
        //        if let user = viewModel.currenrUser {
        NavigationView {
            ZStack {
                VStack() {
                    Section() {
                        HStack {
                            VStack {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.241, height: UIScreen.main.bounds.height * 0.111)
                                    .clipShape(Circle())
                                    .foregroundColor(Color(.systemGray5))
                                    .padding(2)
                                
                                
                            }
                            //                            Divider()
                            VStack(alignment: .leading) {
                                Spacer()
                                Text(user.username)
                                    .font(.system(size: 32,
                                                  weight: .bold,
                                                  design: .default))
                                    .foregroundColor(.primary)
                                Divider()
                                Text("\(user.email)")
//                                    .font(.system(size: 25,
//                                                  weight: .medium,
//                                                  design: .default))
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.111)
                    }
                    //                    Text()
                    //                        .foregroundColor (Color (.black))
                    //                        .fontWeight(.semibold)
                    //                        .font(.system(size: 20))
                    //                        .font(.system(.callout))
                    
                    Spacer(minLength: 30)
                    
                    Button {
                        showNewJokeView.toggle()
                    }
                label:
                    {
                        Text("New joke")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .bold()
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.05)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                    .sheet(isPresented: $showNewJokeView) {
                        NewJokeCreateView()
                    }
                    Button {
                        isAuthenticated = false
                    }
                label:
                    {
                        Text("Sign out")
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.05)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                    
                    
                    
                    
                    //    if isSecureField {
                    //        SecureField (placeholder, text: $text)
                    //            .font (. system(size: 14))
                    //            .foregroundColor(Color(.systemGray))
                    //            .padding()
                    //            .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.07)
                    //            .background(Color(.white))
                    //            .cornerRadius(120)
                    //            .shadow(radius: 15)
                    ////                        .padding()
                    //    } else {
                    //        TextField (placeholder, text: $text)
                    ////                        .font (. system(size: 14))
                    //            .foregroundColor(Color(.systemGray))
                    //            .padding()
                    //            .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.07)
                    //            .background(Color(.white))
                    //            .cornerRadius(120)
                    //            .shadow(radius: 15)
                    ////                        .padding()
                    //    }
                    
                    //                        .frame(width:  UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.15)
                    .padding()
                    
                    
                    VStack {
                        Text("My jokes")
                            .font(.headline)
                            .bold()
                        ScrollView {
                            LazyVStack {
                                ForEach([Joke.MOCK_JOKE]) { joke in
                                    NewJokeView(joke: joke)
                                }
                            }
                        }
                    }
                }
                
                
                //                        .background(Color(.systemBackground))
                //                        .cornerRadius(30)
                //                        .shadow(radius: 5)
                
                
                
                
            }
            //            .tag(Tab.person)
            //        }
            
        }
    }
    
    
    
    
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USER, newJoke: .constant(""))
    }
}
