//
//  MainViewController.swift
//  GeoFood
//
//  Created by Егор on 06.04.2021.
//

import UIKit

/// TabBar контроллер для карты и авторизации
class MainViewController: UITabBarController {
    
    /// Вью загрузилось
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authorizationNavController = UINavigationController(rootViewController: AuthorizationViewController())
        let tabBarItem = UITabBarItem(title: "Аккаунт", image: UIImage(systemName: "person.crop.circle"), tag: 1)

        authorizationNavController.tabBarItem = tabBarItem
        authorizationNavController.navigationBar.layoutMargins.left = 32
        authorizationNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "dark_blue")!]
        //authorizationNavController.tabBarItem.badgeColor = UIColor(named: "dark_blue")
        
        let mapNavController = UINavigationController(rootViewController: MapViewController())
        mapNavController.navigationBar.layoutMargins.left = 32
        mapNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "dark_blue")!]
        mapNavController.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(systemName: "map"), tag: 0)
        viewControllers = [mapNavController, authorizationNavController]
        tabBar.barTintColor = UIColor(named: "light_green")
        tabBar.tintColor = UIColor(named: "dark_blue")
        tabBar.unselectedItemTintColor = UIColor(named: "light_blue")
    }
    
    /// Перерисовка tabbar
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.backgroundColor = UIColor(named: "light_green")
        view.layer.cornerRadius = 10
        tabBar.layer.cornerRadius = 30
        tabBar.layer.masksToBounds = true
        tabBar.frame = CGRect(x: 30, y: tabBar.frame.minY, width: view.frame.width - 60, height: 60)
        tabBar.removeConstraints(tabBar.constraints)
    }
    
}
