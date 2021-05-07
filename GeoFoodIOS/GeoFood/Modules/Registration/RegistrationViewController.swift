//
//  RegistrationViewController.swift
//  GeoFood
//
//  Created by Егор on 13.03.2021.
//

import UIKit

/// Выходные методы контроллера регистрации
protocol RegistrationViewOutput: class {
    func setNavigationBarHidden(_ isHidden: Bool, animated: Bool)
    func showAlert(title: String, message: String)
    func getNavigationController() -> UINavigationController?
}

/// Контроллер регитсрации
class RegistrationViewController: UIViewController {
    
    /// Конфигуратор модуля
    let configurator: RegistrationConfiguratorProtocol = RegistrationConfigurator()
    /// Презентер регистрации
    var presenter: RegistrationPresenterInput!
    
    /// Поле ввода почты
    var emailTextField: TitledTextField = TitledTextField.emailTextField()
    
    /// Поле ввода пароля
    var passwordTextField: TitledTextField = TitledTextField.passwordTextField()
    
    /// Поле повторного ввода пароля
    var repeatPasswordTextField = TitledTextField.passwordTextField()
    /// Кнопка регистрации
    let registrationButton = UIButton()
    /// Кнопка возвращения на экран авторизации
    let backButton = UIButton()
    
    /// Контроллер загружен
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
        view.backgroundColor = .systemBackground
        title = "Регистрация"
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        configureSubviews()
        addAllSubviews()
        initConstraints()
    }
    
    /// Контроллер отобразился
    /// - Parameter animated: Анимировано ли
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.tabBarItem.title = self.title
        presenter.viewDidAppear()
    }
    
    /// Конфигурировать вью
    private func configureSubviews() {
        configureEmailTextField()
        configurePasswordTextField()
        configureRepeatPasswordTextField()
        configureRegistrationButton()
        configureBackButton()
    }
    
    /// Конфигурировать поле ввода почты
    private func configureEmailTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Конфигурировать поле ввода пароля
    private func configurePasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Конфигурировать поле ввода пароля повторно
    private func configureRepeatPasswordTextField() {
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordTextField.titleText = "Повторите пароль"
    }
    
    /// Конфигурировать кнопку регистрации
    private func configureRegistrationButton() {
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.setTitleColor(UIColor(named: "dark_blue"), for: .normal)
        registrationButton.layer.borderColor = UIColor(named: "light_green")?.cgColor
        registrationButton.layer.borderWidth = 2
        registrationButton.layer.cornerRadius = 10
        registrationButton.backgroundColor = UIColor(named: "lime")
        registrationButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
    }
    
    /// Конфигурировать кнопку возврата
    private func configureBackButton() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let attrString = NSAttributedString(string: "Войти", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue])
        backButton.setAttributedTitle(attrString, for: .normal)
        backButton.setTitleColor(UIColor(named: "dark_blue"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    /// Добавить все вью
    private func addAllSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(registrationButton)
        view.addSubview(backButton)
    }
    
    /// Активировать констреинты
    private func initConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 80),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 7),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 80),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 7),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 80),
            
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 22),
            registrationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 46),
            registrationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -46),
            registrationButton.heightAnchor.constraint(equalToConstant: 50),
            
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -66),
            backButton.topAnchor.constraint(greaterThanOrEqualTo: registrationButton.bottomAnchor, constant: 20)
            
        ])
    }
    
    
    
    /// Проверить повторно введенные пароль
    /// - Parameter password: Строка пароля
    /// - Returns: Результат проверки
    private func repeatPasswordValidator(_ password: String) -> Bool {
        passwordTextField.titleText! == password
    }
    
    /// Событие нажатия на кнопку регистрации
    @objc func registrationButtonTapped() {
        presenter.registrationButtonTapped(withEmail: emailTextField.text, password: passwordTextField.text, passwordRepeat: repeatPasswordTextField.text)
    }
    
    /// Событие нажатия на кнопку выхода из вью
    @objc func backButtonTapped() {
        presenter.backButtonTapped()
    }
}

extension RegistrationViewController: RegistrationViewOutput {
    /// Поставить видимость навигации
    /// - Parameters:
    ///   - isHidden: Спрятан ли
    ///   - animated: Анимировано
    func setNavigationBarHidden(_ isHidden: Bool, animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /// Показать сообщение
    /// - Parameters:
    ///   - title: Заголовок сообщения
    ///   - message: Текст сообщения
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    /// Получить контроллер навигации
    /// - Returns: Контроллер навигации
    func getNavigationController() -> UINavigationController? {
        navigationController
    }
}

