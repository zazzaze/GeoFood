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
    
    let backgroundImage = UIImageView(image: UIImage(named: "auth_background"))
    let emailTextField = TitledTextField.emailTextField()
    let passwordTextField = TitledTextField.passwordTextField()
    let authorizationButton = NextButton()
    let registrationButton = UIButton(frame: .zero)
    let activityIndicator = UIActivityIndicatorView(frame: .zero)
    let subtitleLabel = UILabel(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    let smallSubtitleLabel = UILabel(frame: .zero)
    let footerLabel = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(named: "dark_blue")
        
        configurator.configure(with: self)
        view.backgroundColor = UIColor.systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureSubviews()
        addAllSubviews()
        initConstraints()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.tabBarItem.title = "Авторизация"
        presenter.viewDidAppear()
    }
    
    private func configureSubviews() {
        configureBackgroundImage()
        configureSubtitleLabel()
        configureTitleLabel()
        configureSmallSubtitleLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureAuthorizationButton()
        configureRegistrationButton()
        configureFooterLabel()
        configureActivityIndicator()
    }
    
    private func configureBackgroundImage() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    private func configureSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false;
        subtitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        subtitleLabel.textColor = UIColor(named: "dark_blue")
        subtitleLabel.text = "Welcome to"
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor(named: "dark_blue")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 38)
        titleLabel.text = "GeoFood"
    }
    
    private func configureSmallSubtitleLabel() {
        smallSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        smallSubtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        smallSubtitleLabel.textColor = UIColor(named: "light_blue")
        smallSubtitleLabel.numberOfLines = 2
        smallSubtitleLabel.text = """
Введите Email и пароль для
авторизации
"""
    }
    
    private func configureEmailTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configurePasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAuthorizationButton() {
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.setTitle("Войти", for: .normal)
        authorizationButton.addTarget(self, action: #selector(authorizationButtonTapped), for: .touchUpInside)
    }
    
    private func configureFooterLabel() {
        footerLabel.translatesAutoresizingMaskIntoConstraints = false;
        footerLabel.textColor = UIColor(named: "dark_blue")
        footerLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        footerLabel.text = "Нет аккаунта?"
    }
    
    private func configureRegistrationButton() {
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        let attrString = NSAttributedString(string: "Зарегистрироваться", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue])
        registrationButton.setAttributedTitle(attrString, for: .normal)
        registrationButton.setTitleColor(UIColor(named: "dark_blue"), for: .normal)
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.color = .darkGray
    }
    
    private func addAllSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(subtitleLabel)
        view.addSubview(titleLabel)
        view.addSubview(smallSubtitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(authorizationButton)
        view.addSubview(footerLabel)
        view.addSubview(footerLabel)
        view.addSubview(registrationButton)
        view.addSubview(activityIndicator)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.385),
            
            subtitleLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -10),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -100),
            
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            
            smallSubtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            smallSubtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            smallSubtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: smallSubtitleLabel.bottomAnchor, constant: 3),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 80),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 7),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            authorizationButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 26),
            authorizationButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            authorizationButton.heightAnchor.constraint(equalToConstant: 50),
            authorizationButton.widthAnchor.constraint(equalToConstant: 120),
            
            footerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            footerLabel.topAnchor.constraint(equalTo: authorizationButton.bottomAnchor, constant: 25),
            footerLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 30),
            footerLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -30),
            
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.topAnchor.constraint(equalTo: footerLabel.bottomAnchor, constant: 1.54),
            registrationButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 30),
            registrationButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -30),
            
            
            
//
//            passwordTextField.bottomAnchor.constraint(equalTo: authorizationButton.topAnchor, constant: -20),
//            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//
//            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
//            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//
//            registrationButton.topAnchor.constraint(equalTo: authorizationButton.bottomAnchor, constant: 20),
//            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func authorizationButtonTapped() {
        presenter.authorizationButtonTapped(withEmail: emailTextField.text, password: passwordTextField.text)
    }
    
    @objc private func registrationButtonTapped() {
        presenter.registrationButtonTapped()
    }
    
    @objc private func textFieldChanged() {
        presenter.textFieldChanged(email: emailTextField.text, password: passwordTextField.text)
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
