//
//  AccountViewController.swift
//  GeoFood
//
//  Created by Егор on 04.05.2021.
//

import UIKit

protocol AccountViewOutput: AnyObject {
    func logoutTapped()
    func viewDidLoad()
}

protocol AccountViewInput: AnyObject {
    func configure(with viewModel: UserViewModel)
}

class AccountViewController: UIViewController, AccountViewInput {
    
    var logoutButton = UIButton()
    var emailTitle = UILabel()
    var userEmail = UILabel()
    
    var output: AccountViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Аккаунт"
        let background = UIImage(named: "background")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        navigationItem.setHidesBackButton(true, animated: false)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Выйти", for: .normal)
        logoutButton.setTitleColor(UIColor(named: "dark_blue"), for: .normal)
        logoutButton.layer.borderColor = UIColor(named: "light_green")?.cgColor
        logoutButton.layer.borderWidth = 2
        logoutButton.layer.cornerRadius = 10
        logoutButton.backgroundColor = UIColor(named: "lime")
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        view.addSubview(logoutButton)
        
        emailTitle.translatesAutoresizingMaskIntoConstraints = false
        emailTitle.attributedText = NSAttributedString(string: "Ваша почта:", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue])
        emailTitle.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        emailTitle.textColor = UIColor(named: "dark_blue")
        view.addSubview(emailTitle)
        
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        userEmail.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        userEmail.textColor = UIColor(named: "light_blue")
        view.addSubview(userEmail)
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            
            emailTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            emailTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            userEmail.topAnchor.constraint(equalTo: emailTitle.bottomAnchor, constant: 10),
            userEmail.leadingAnchor.constraint(equalTo: emailTitle.leadingAnchor)
        ])
        output.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.tabBarItem.title = self.title
    }
    
    @objc private func logoutButtonTapped() {
        output.logoutTapped()
    }
    
    func configure(with viewModel: UserViewModel) {
        self.userEmail.text = viewModel.login
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
