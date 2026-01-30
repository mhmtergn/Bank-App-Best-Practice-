//
//  MainTabBarController.swift
//  Bank_App(Best Practice)
//
//  Created by Mehmet Ergun on 1/28/26.
//

import Foundation

import UIKit

final class MainTabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTabs()
        setupTabBarAppearance()
    }

    
    //MARK: TABS
    private func setupTabs() {
        
        let vc1 = AccountSummaryVC()
        let vc2 = MoveMoneyVC()
        let vc3 = MoreVC()
        
        vc1.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        vc2.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        vc3.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        let summaryNav = UINavigationController(rootViewController: vc1)
        let moveMoneyNav = UINavigationController(rootViewController: vc2)
        let moreNav = UINavigationController(rootViewController: vc3)
        
        summaryNav.navigationBar.barTintColor = .systemBlue
        hideNavigationBarLine(summaryNav.navigationBar)
        
        let tabBarList = [summaryNav, moveMoneyNav, moreNav]
        viewControllers = tabBarList
        
        selectedIndex = 0
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .systemBlue
        tabBar.isTranslucent = false
    }
    
    
    //MARK: TAB BARS APPEARANCE
    private func setupTabBarAppearance() {
        tabBar.tintColor = .systemIndigo
        tabBar.unselectedItemTintColor = .secondaryLabel
        
        //iOS 13+
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

