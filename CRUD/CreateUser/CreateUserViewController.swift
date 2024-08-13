//
//  CreateUserViewController.swift
//  CRUD
//
//  Created by Gustavo Kamitani on 08/08/24.
//

import Foundation
import UIKit

class CreateUserViewController: UIViewController {

    var rightButton: UIButton!
    var leftButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(.white)
        configureNavigationBar()
        configureUIElements()
    }
    
    func configureNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = ""
        navigationItem.titleView = titleLabel
    }
    
    func configureUIElements() {
        let titleLabel = UILabel()
        titleLabel.text = "Informações \ndo Arremessador"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .darkText
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Precisamos de algumas informações adicionais para salvar no base de dados."
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        
        let teamTextField = createTextFieldWithBottomBorder(placeholder: "Time")
        let nameTextField = createTextFieldWithBottomBorder(placeholder: "Nome")
        let numberTextField = createTextFieldWithBottomBorder(placeholder: "Número")
        
        // Utilizar as propriedades da classe para os botões
        rightButton = UIButton(type: .system)
        rightButton.setTitle("Destro", for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        rightButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rightButton.backgroundColor = .systemBlue
        rightButton.layer.borderWidth = 1
        rightButton.layer.borderColor = UIColor.systemBlue.cgColor
        rightButton.setTitleColor(.white, for: .normal)
        roundButtonCorners(rightButton, radius: 10)
        
        leftButton = UIButton(type: .system)
        leftButton.setTitle("Canhoto", for: .normal)
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        leftButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leftButton.backgroundColor = .white
        leftButton.layer.borderWidth = 1
        leftButton.layer.borderColor = UIColor.systemBlue.cgColor
        leftButton.setTitleColor(.systemBlue, for: .normal)
        roundButtonCorners(leftButton, radius: 10)
        
        let buttonStackView = UIStackView(arrangedSubviews: [rightButton, leftButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 20
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        
        let addButton = UIButton(type: .system)
        addButton.setTitle("Adicionar", for: .normal)
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.backgroundColor = .systemBlue
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.systemBlue.cgColor
        addButton.setTitleColor(.white, for: .normal)
        roundButtonCorners(addButton, radius: 10)
        
        let stackView = UIStackView(arrangedSubviews: [teamTextField, nameTextField, numberTextField, buttonStackView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 30
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(stackView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonStackView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 40),
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: rightButton.bottomAnchor, constant: 40)
        ])
    }
    
    func createTextFieldWithBottomBorder(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1) // Ajuste aqui
        
        bottomLine.backgroundColor = UIColor.systemGray3.cgColor
        textField.layer.addSublayer(bottomLine)
        textField.layer.masksToBounds = true
        
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.layoutIfNeeded()
        
        DispatchQueue.main.async {
            bottomLine.frame = CGRect(x: 0, y: textField.bounds.height - 1, width: textField.bounds.width, height: 1)
        }
        
        return textField
    }
    
    func roundButtonCorners(_ button: UIButton, radius: CGFloat) {
        button.layer.cornerRadius = radius
    }

    @objc func rightButtonTapped() {
        rightButton.backgroundColor = .systemBlue
        rightButton.setTitleColor(.white, for: .normal)
        
        leftButton.backgroundColor = .white
        leftButton.setTitleColor(.systemBlue, for: .normal)
        leftButton.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @objc func leftButtonTapped() {
        leftButton.backgroundColor = .systemBlue
        leftButton.setTitleColor(.white, for: .normal)
        
        rightButton.backgroundColor = .white
        rightButton.setTitleColor(.systemBlue, for: .normal)
        rightButton.layer.borderColor = UIColor.systemBlue.cgColor
    }

}
