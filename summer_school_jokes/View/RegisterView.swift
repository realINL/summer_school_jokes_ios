//
//  RegisterView.swift
//  summer_school_jokes
//
//  Created by admin on 17.07.2024.
//

import SwiftUI

struct RegisterView: View {
    @Binding var email: String
    @Binding var username: String
    @Binding var password: String
    var body: some View {
        VStack {
            HStack {
                Label("Summer school jokes", systemImage: "book")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
            
            Spacer()
            
            TextField("Your email", text: $email)
                
                .foregroundColor(Color("WhiheSmoke"))
                .padding()
                .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.07)
                .background(Color("WhiteSmoke"))
                .cornerRadius(10)
            
            TextField("Your username", text: $username)
                
                .foregroundColor(Color("WhiheSmoke"))
                .padding()
                .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.07)
                .background(Color("WhiteSmoke"))
                .cornerRadius(10)
//                .shadow(radius: 15)

            SecureField("Your password", text: $password)
                .foregroundColor(Color("WhiheSmoke"))
                .padding()
                .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.07)
                .background(Color("WhiteSmoke"))
                .cornerRadius(10)
            
            Button {
                
            } label: {
                Text("Sign up")
//                    .foregroundColor(Color("WhiheSmoke"))
                    .padding()
                    .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.07)
                    .background(Color("WhiteSmoke"))
                    .cornerRadius(10)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue))
    //                .shadow(radius: 15)

            }
            
            Button {
                
            } label: {
                Text("Log in")
//                    .foregroundColor(Color("WhiheSmoke"))
                    .padding()
//                    .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.07)
//                    .background(Color("WhiteSmoke"))
//                    .cornerRadius(10)
//                    .overlay( /// apply a rounded border
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(.blue))
    //                .shadow(radius: 15)

            }
            
            Spacer()
        }
        
        
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(email: .constant(""), username: .constant(""), password: .constant(""))
    }
}
