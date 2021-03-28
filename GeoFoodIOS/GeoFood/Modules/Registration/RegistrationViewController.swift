//
//  RegistrationViewController.swift
//  GeoFood
//
//  Created by Егор on 13.03.2021.
//

import UIKit

protocol RegistrationViewProtocol: class {
    func setNavigationBarHidden(_ isHidden: Bool, animated: Bool)
    func showAlert(title: String, message: String)
    func getNavigationController() -> UINavigationController?
}

class RegistrationViewController: UIViewController {

    let configurator: RegistrationConfiguratorProtocol = RegistrationConfigurator()
    var presenter: RegistrationPresenterProtocol!
    
    var emailTextField: TextFieldWithConditions = {
        let emailCondition = TextFieldCondition(description: "Email имеет вид example@example.com", checker: LoginEntryChecker.checkEmail)
        return TextFieldWithConditions(conditions: [emailCondition])
    }()
    
    var passwordTextField: TextFieldWithConditions = {
        let passwordCondition = TextFieldCondition(description: "Длина пароля больше 8", checker: LoginEntryChecker.checkPassword)
        return TextFieldWithConditions(conditions: [passwordCondition])
    }()
    
    var repeatPasswordTextField: TextFieldWithConditions!
    let registrationButton = UIButton()
    
    convenience init() {
        self.init()
        configurator.configure(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Регистрация"
        
        configureSubviews()
        addAllSubviews()
        initConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    private func configureSubviews() {
        configureEmailTextField()
        configurePasswordTextField()
        configureRepeatPasswordTextField()
        configureRegistrationButton()
    }
    
    private func configureEmailTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.textColor = .black
        emailTextField.keyboardType = .emailAddress
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    private func configurePasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.textColor = .black
        passwordTextField.isSecureTextEntry = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    private func configureRepeatPasswordTextField() {
        let repeatPasswordCondition = TextFieldCondition(description: "Пароли должны совпадать", checker: repeatPasswordValidator)
        
        repeatPasswordTextField = TextFieldWithConditions(conditions: [repeatPasswordCondition])
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordTextField.textColor = .black
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль повторно", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    private func configureRegistrationButton() {
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.setTitleColor(.systemBlue, for: .normal)
        registrationButton.setTitleColor(.lightGray, for: .disabled)
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
    }
    
    private func addAllSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(registrationButton)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 20)
        ])
    }
    
    
    
    private func repeatPasswordValidator(_ password: String) -> Bool {
        passwordTextField.text! == password
    }
    
    @objc func registrationButtonTapped() {
        presenter.registrationButtonTapped(withEmail: emailTextField.text!, password: passwordTextField.text!, passwordRepeat: repeatPasswordTextField.text!)
    }
}

extension RegistrationViewController: RegistrationViewProtocol {
    func setNavigationBarHidden(_ isHidden: Bool, animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func getNavigationController() -> UINavigationController? {
        navigationController
    }
}

