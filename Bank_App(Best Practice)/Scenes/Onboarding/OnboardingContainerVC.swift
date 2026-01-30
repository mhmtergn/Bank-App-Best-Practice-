//
//  OnboardingContainerVC.swift
//  Bank_App(Best Practice)
//
//  Created by Mehmet Ergun on 1/29/26.
//

import Foundation
import UIKit

protocol OnboardingContainerVCDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingContainerVC: UIViewController {
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else {return}
            nextButton.isHidden = index == pages.count - 1 // hide if on the last page
            backButton.isHidden = index == 0
            doneButton.isHidden = !(index == pages.count - 1) // show if on the last page
        }
    }
    let closeButton = UIButton()
    let nextButton = UIButton()
    let backButton = UIButton()
    let skipButton = UIButton()
    let doneButton = UIButton()
    
    weak var delegate: OnboardingContainerVCDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingVC(heroImageName: "delorean", titleText: "Bankey is faster, easier to user, and has a brand new look and feel that will make you feel like you are back in 1989!")
        let page2 = OnboardingVC(heroImageName: "world", titleText: "Move your money around the world quickly and securely")
        let page3 = OnboardingVC(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingContainerVC {
    private func setup() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self]).pageIndicatorTintColor = .systemGray2
        UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self]).currentPageIndicatorTintColor = .systemBlue
        
        NSLayoutConstraint.activate([
            
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([currentVC], direction: .forward, animated: true, completion: nil)
        currentVC = pages.first!
    }
    
    private func style() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(closeButton)
        view.addSubview(nextButton)
        view.addSubview(backButton)
        view.addSubview(doneButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.setTitleColor(.systemBlue, for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.setTitleColor(.systemBlue, for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: [])
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.setTitleColor(.systemBlue, for: .normal)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
    
    }
    
    private func layout() {
        // Close
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
        ])
        
        //Next
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
        ])
        
        //Back
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
        ])
        
        //Done
        NSLayoutConstraint.activate([
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
        ])
    }
}

extension OnboardingContainerVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else {return nil}
        currentVC = pages[index - 1]
        return pages[index - 1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else {return nil}
        currentVC = pages[index + 1]
        return pages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
    
}

// MARK: - ACTIONS

extension OnboardingContainerVC {
    
    @objc func closeTapped() {
        delegate?.onboardingDidFinish()
    }
    
    @objc func nextTapped() {
        guard let nextVC = getNextViewController(from: currentVC) else {return}
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true)
    }
    
    @objc func backTapped() {
        guard let previousVC = getPreviousViewController(from: currentVC) else {return}
        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true)
    }
    
    @objc func doneTapped() {
        delegate?.onboardingDidFinish()
    }
    
}
