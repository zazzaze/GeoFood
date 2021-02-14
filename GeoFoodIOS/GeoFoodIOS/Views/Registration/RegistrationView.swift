//
//  RegistrationView.swift
//  GeoFoodIOS
//
//  Created by Егор on 13.02.2021.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var login: String
    @Binding var password: String
    @State var isInProgress = false
    @State var isAlertPresented = false
    
    let client = ServerClient()
    
    private var isLoginCorrect: Bool {
        return !hasSpaces(in: login) && isLengthCorrect(value: login, min: 4)
    }
    
    private func hasSpaces(in value: String) -> Bool {
        return value.contains(" ")
    }
    
    private func isLengthCorrect(value: String, min length: Int) -> Bool {
        return value.count > length
    }
    
    var isPasswordCorrect: Bool {
        return !hasSpaces(in: password) && isLengthCorrect(value: password, min: 4)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            RegistrationForm(login: $login, password: $password) {
                client.registerUser(login: login, password: password) { isSuccess in
                    if isSuccess {
                        DispatchQueue.main.async {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } else {
                        isAlertPresented = true
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 15)
        .alert(isPresented: $isAlertPresented) {
            Alert(title: Text("Ошибка"), message: Text("Не удалось зарегестрироватсья"), dismissButton: .default(Text("Попробовать снова")))
        }
        .navigationTitle(Text("Регистрация"))
    }
}

//struct RegistrationView_Previews: PreviewProvider {
//    @State var login: String
//    @State var password: String
//    static var previews: some View {
//        RegistrationView(login: $login, $password: password)
//    }
//}
