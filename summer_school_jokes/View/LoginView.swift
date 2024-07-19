import SwiftUI


struct LogInView: View {
    @Binding var username: String
    @Binding var password: String
    @StateObject private var networkManager = NetworkManager()
    @State private var loginFailed = false
    @State var profilShow: Bool = false
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
            TextField("Your username", text: $username)
                
                .foregroundColor(.primary)
                .padding()
                .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.07)
                .background(Color("WhiteSmoke"))
                .cornerRadius(10)
//                .shadow(radius: 15)

            SecureField("Your password", text: $password)
                .foregroundColor(.primary)
                .padding()
                .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.07)
                .background(Color("WhiteSmoke"))
                .cornerRadius(10)
            
            Button {
                networkManager.login(username: username, password: password) { success in
                                    if success {
                                        profilShow.toggle()
                                        print("Login successful")
                                    } else {
                                        loginFailed = true
                                        print("Login failed")
                                    }
                                }
            } label: {
                Text("Log in")
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
                Text("Sign up")
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
//        .fullScreenCover(isPresented: $profilShow){
//            ProfileView(user: User.MOCK_USER, newJoke: .constant(""))
//        }
        
    }
    
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(username: .constant(""), password: .constant(""))
    }
}

