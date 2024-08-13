//
//  ViewController.swift
//  CRUD
//
//  Created by Gustavo Kamitani on 08/08/24.
//


import UIKit

class ViewController: UIViewController {

    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap Me", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 80),
            button.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func didTapButton() {
        let createPlayerVC = CreateUserViewController()
        self.navigationController?.pushViewController(createPlayerVC, animated: true)
    }
}
