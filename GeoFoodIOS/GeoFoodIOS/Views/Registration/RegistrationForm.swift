//
//  RegistrationForm.swift
//  GeoFoodIOS
//
//  Created by Егор on 13.02.2021.
//

import SwiftUI

struct RegistrationForm: View {
    @Binding var login: String
    @Binding var password: String
    
    var buttonPressed: () -> ()
    
    private var isLoginCorrect: Bool {
        !hasSpaces(in: login) && isLengthCorrect(value: login, min: 4)
    }
    
    private var isPasswordCorrect: Bool {
        !hasSpaces(in: password) && isLengthCorrect(value: password, min: 4)
    }

    
    private func hasSpaces(in value: String) -> Bool {
        value.contains(" ")
    }
    
    private func isLengthCorrect(value: String, min: Int) -> Bool {
        value.count > min
    }
    
    private func isLoginHasSpaces() -> Bool {
        !hasSpaces(in: login)
    }
    
    private func isLoginLengthCorrect() -> Bool {
        isLengthCorrect(value: login, min: 4)
    }
    
    private func isPasswordLengthCorrect() -> Bool {
        isLengthCorrect(value: password, min: 4)
    }
    
    private func isPasswordHasSpaces() -> Bool {
        !hasSpaces(in: password)
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                TextField("Login", text: $login)
                    .padding(.horizontal, 2)
                    .padding(.vertical, 5)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(isLoginCorrect ? .gray : .red)
                            .padding(.vertical, 0),
                        alignment: .bottom
                    )
                
                TextFieldCondition(correctConditionImageName: "checkedCheckbox", incorrectConditionImageName: "uncheckedCheckbox", condition: isLoginLengthCorrect, text: "больше 4 латинских букв")
                
                TextFieldCondition(correctConditionImageName: "checkedCheckbox", incorrectConditionImageName: "uncheckedCheckbox", condition: isLoginHasSpaces, text: "не содержит символов пробела")
                
            }
            
            VStack(alignment: .leading, spacing: 10) {
                
                SecureField("Password", text: $password)
                    .padding(.vertical, 5)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(isPasswordCorrect ? .blue : .red)
                            .padding(.vertical, 0),
                        alignment: .bottom
                    )
                
                TextFieldCondition(correctConditionImageName: "checkedCheckbox", incorrectConditionImageName: "uncheckedCheckbox", condition: isPasswordLengthCorrect, text: "больше 4 латинских букв")
                
                TextFieldCondition(correctConditionImageName: "checkedCheckbox", incorrectConditionImageName: "uncheckedCheckbox", condition: isPasswordHasSpaces, text: "не содержит символов пробела")
                
            }
            
            Button("Зарегестрироваться") {
                buttonPressed()
            }
        }
    }
}

//struct RegistrationForm_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistrationForm()
//    }
//}
