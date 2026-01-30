//
//  SceneDelegate.swift
//  Bank_App(Best Practice)
//
//  Created by Mehmet Ergun on 1/24/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerVC = OnboardingContainerVC()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        loginViewController.delegate = self
        onboardingContainerVC.delegate = self
        
        if LocalState.hasLogined {
            if LocalState.hasOnboarded {
                window.rootViewController = MainTabBarController()
            } else {
                window.rootViewController = onboardingContainerVC
            }
        } else  {
            let nav = UINavigationController(rootViewController: loginViewController)
            window.rootViewController = nav
        }
        
        self.window = window
        window.makeKeyAndVisible()
    }

}
extension SceneDelegate: LoginViewControllerDelegate {
    func didLogin() {
    
        
        
        if LocalState.hasOnboarded {
            setRootViewController(MainTabBarController())
        } else {
            setRootViewController(loginViewController)
        }
        
    }
}

extension SceneDelegate: OnboardingContainerVCDelegate {
    func onboardingDidFinish() {
        
        LocalState.hasOnboarded = true
        
        setRootViewController(MainTabBarController())
    }
}

extension SceneDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil)
        
    }
}


extension SceneDelegate {
    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
