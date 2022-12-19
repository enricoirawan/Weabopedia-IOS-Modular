//
//  ViewController.swift
//  Weabopedia Modular
//
//  Created by Enrico Irawan on 18/12/22.
//

import UIKit
import Home
import Favorite
import Search
import Account

class BaseViewController: UITabBarController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomNav()
    }
    
    private func setupBottomNav() {
        let homeImage = UIImage(systemName: "house")
        let homeVC = HomeModule().container.resolve(HomeViewController.self)
        let home = templateNavigationController(image: homeImage, rootViewController: homeVC!, title: "Home")
        
        let searchImage = UIImage(systemName: "magnifyingglass")
        let searchVC = SearchModule().container.resolve(SearchViewController.self)
        let search = templateNavigationController(image: searchImage, rootViewController: searchVC!, title: "Search")
        
        let favoriteImage = UIImage(systemName: "heart")
        let favoriteVC = FavoriteModule().container.resolve(FavoriteViewController.self)
        let favorite = templateNavigationController(image: favoriteImage, rootViewController: favoriteVC!, title: "Favorite")
        
        let accountImage = UIImage(systemName: "person")
        let account = templateNavigationController(image: accountImage, rootViewController: AccountViewController(), title: "Account")
        
        viewControllers = [home, search, favorite, account]
    }
    
    // MARK: - Helper
    private func templateNavigationController(image: UIImage?, rootViewController: UIViewController, title: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        nav.navigationBar.tintColor = .white
        
        tabBar.tintColor = .systemOrange
        tabBar.backgroundColor = .systemBackground
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        return nav
    }
}
