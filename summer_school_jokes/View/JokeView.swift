//
//  JJOkeView.swift
//  summer_school_jokes
//
//  Created by admin on 12.07.2024.
//

import SwiftUI

struct JokeView: View {
    @State private var numberOfLikes: Int = 5
    @State private var like: Bool = false
    
    var body: some View {
        VStack {
            HStack{
                Image("IMG_3597")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.075, height: UIScreen.main.bounds.width * 0.075)
                    .clipShape(Circle())
                    .padding(2)
                
                Text("Julia Arbuzova")
                
                Spacer()
                
                Menu {
                    Button {}
                label: {
                        Label("Save", systemImage: "bookmark")
                    }
                    Button {}
                label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.primary)
                }
            }
            

//            .foregroundColor(.blue)
//            .padding(0)
//            Divider()
            HStack() {
                
                Text(" - Знаешь какая часть овоща самая трудножущаяся?\n - Инвалидная коляска.")
                    .foregroundColor(.primary)
                
                Spacer()
            }
//            Divider()
                
            HStack {
                Spacer()
                
                Button{
                    like.toggle()
                    if (like) {
                        numberOfLikes = numberOfLikes + 1
                    } else {
                        numberOfLikes = numberOfLikes - 1
                    }
                }
            label: {
                VStack {
                    if (!like) {
                        Image (systemName: "hand.thumbsup")
                            .foregroundColor(.black)
                    } else {
                        Image (systemName: "hand.thumbsup.fill")
                            .foregroundColor(.black)
                        
                    }
                    //            .cornerRadius(120)
                    //                    .background(Color(.systemGreen))
                    
                    Text("\(numberOfLikes)")
                        .font(.callout)
                        .foregroundColor(.black)
                }
                
            }
                
                
            }
        }
        .padding()
        //        .frame(width:  UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.06)
        .background(Color(.systemBackground))
        //        .cornerRadius(30)
        .shadow(radius: 5)
        .padding()
        
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}
