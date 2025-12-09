//
//  MainTabBarController.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 09/12/25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))

        let addVC = UINavigationController(rootViewController: AddHabitViewController())
        addVC.tabBarItem = UITabBarItem(title: "Add",
                                           image: UIImage(systemName: "plus.circle"),
                                           selectedImage: UIImage(systemName: "plus.circle.fill"))

        let progressVC = UINavigationController(rootViewController: ProgressViewController())
        progressVC.tabBarItem = UITabBarItem(title: "Progress",
                                            image: UIImage(systemName: "chart.bar"),
                                            selectedImage: UIImage(systemName: "chart.bar.fill"))

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                            image: UIImage(systemName: "person"),
                                            selectedImage: UIImage(systemName: "person.fill"))

        viewControllers = [homeVC, addVC, progressVC, profileVC]
        tabBar.tintColor = .label
//        setupAppearance()
    }

    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = .clear

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tabBar.clipsToBounds = true
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.08
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 8
        tabBar.layer.shadowPath = UIBezierPath(rect: tabBar.bounds).cgPath
    }
}

