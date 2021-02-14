//
//  ContentView.swift
//  GeoFoodIOS
//
//  Created by Егор on 15.01.2021.
//

import SwiftUI

struct LoginView: View {
    
    @State var login: String = ""
    @State var password: String = ""
    @State var selection: Bool = false
    @State var isInProgress = false
    @State var isAlertShow = false
    @Binding var token: String?
    
    let client = ServerClient()
    @State var userInfo: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 15) {
                    Text("GeoFood".uppercased())
                        .font(.system(size: 36))
                    TextField("Email", text: $login)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                    NavigationLink(
                        destination: MainView(token: $token),
                        isActive: $selection) {
                        Button("Log in") {
                            tryLogIn()
                        }
                    }
                    
                    NavigationLink("Зарегестрироваться", destination: RegistrationView(login: $login, password: $password))
                }
                .padding(.horizontal, 15)
                .blur(radius: isInProgress ? 1 : 0, opaque: false)
                .alert(isPresented: $isAlertShow) {
                    Alert(title: Text("Ошибка"), message: Text("при попытке авторизоваться произошла ошибка"), dismissButton: .default(Text("Ok")))
                }
                
                LoaderView(isInProgress: $isInProgress)
            }
            .navigationBarHidden(true)
        }
    }
    
    private func tryLogIn() {
        isInProgress = true
        client.authUser(login: login, password: password) { token in
            guard let token = token else {
                isInProgress = false
                isAlertShow.toggle()
                return
            }
            self.token = token
            UserDefaults.standard.setValue(token, forKey: "geofoodToken")
            self.isInProgress = false
            self.selection = true
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            LoginView()
//        }
//    }
//}
