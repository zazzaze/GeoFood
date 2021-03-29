//
//  ViewController.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import UIKit

protocol AuthorizationViewProtocol: class {
    func setAuthorizationButtonIsEnabled(_ isEnabled: Bool)
    func showAlert(title: String, message: String)
    func setNavigationBarHidden(_ isHidden: Bool, animated: Bool)
    func startAnimatingActivityIndicator()
    func stopAnimatingActivityIndicator()
    func getNavigationController() -> UINavigationController?
}

class AuthorizationViewController: UIViewController {

    var presenter: AuthorizationPresenterProtocol!
    var configurator = AuthorizationConfigurator()
    
    let titleLabel = UILabel(frame: .zero)
    let emailTextField = UITextField(frame: .zero)
    let passwordTextField = UITextField(frame: .zero)
    let authorizationButton = UIButton(frame: .zero)
    let registrationButton = UIButton(frame: .zero)
    let activityIndicator = UIActivityIndicatorView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        view.backgroundColor = .white
        title = "Авторизация"
        configureSubviews()
        addAllSubviews()
        initConstraints()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    private func configureSubviews() {
        configureTitleLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureAuthorizationButton()
        configureRegistrationButton()
        configureActivityIndicator()
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Авторизация"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
    }
    
    private func configureEmailTextField() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailTextField.textColor = .black
        emailTextField.keyboardType = .emailAddress
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configurePasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField.textColor = .black
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    private func configureAuthorizationButton() {
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.setTitle("Войти", for: .normal)
        authorizationButton.setTitleColor(.systemBlue, for: .normal)
        authorizationButton.setTitleColor(.lightGray, for: .disabled)
        authorizationButton.addTarget(self, action: #selector(authorizationButtonTapped), for: .touchUpInside)
    }
    
    private func configureRegistrationButton() {
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.setTitle("Зарегестрироваться", for: .normal)
        registrationButton.setTitleColor(.systemBlue, for: .normal)
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.color = .darkGray
    }
    
    private func addAllSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(authorizationButton)
        view.addSubview(registrationButton)
        view.addSubview(activityIndicator)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            authorizationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            passwordTextField.bottomAnchor.constraint(equalTo: authorizationButton.topAnchor, constant: -20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            registrationButton.topAnchor.constraint(equalTo: authorizationButton.bottomAnchor, constant: 20),
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func authorizationButtonTapped() {
        presenter.authorizationButtonTapped(withEmail: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @objc private func registrationButtonTapped() {
        presenter.registrationButtonTapped()
    }
    
    @objc private func textFieldChanged() {
        presenter.textFieldChanged(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
}

extension AuthorizationViewController: AuthorizationViewProtocol {
    func startAnimatingActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopAnimatingActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func setAuthorizationButtonIsEnabled(_ isEnabled: Bool) {
        authorizationButton.isEnabled = isEnabled
    }
    
    func setNavigationBarHidden(_ isHidden: Bool, animated: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }
    
    func getNavigationController() -> UINavigationController? {
        navigationController
    }
}
