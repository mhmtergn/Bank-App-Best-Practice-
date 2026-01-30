//
//  FavoritesVC.swift
//  Bank_App(Best Practice)
//
//  Created by Mehmet Ergun on 1/28/26.
//


import UIKit

final class MoveMoneyVC: UIViewController {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
        view.backgroundColor = .systemGreen
    }
    
}

extension MoveMoneyVC {
    
    private func style() {
        //StackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        
        
        
        
        //Image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        
    }
    
    private func layout() {
        stackView.addArrangedSubview(imageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
        ])
        
    }
}
