//
//  CreateUserViewController.swift
//  CRUD
//
//  Created by Gustavo Kamitani on 08/08/24.
//

import UIKit

class CreateUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var teamPickerView: UIPickerView!
    var teamInputField: UITextField!

    var rightButton: UIButton!
    var leftButton: UIButton!
    var nameTextField: UITextField!
    var numberTextField: UITextField!
    var isRightHand: Bool = true

    let teams = ["Anhanguera", "Atibaia", "Dourados", "Gecebs", "Ibiúna", "Londrina", "Marília", "Maringá", "MT", "Medicina USP", "Nikkei Curitiba", "Nippon Blue Jays", "Pinheiros", "Presidente Prudente"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
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
        
        // Configuração do UIPickerView
        teamPickerView = UIPickerView()
        teamPickerView.delegate = self
        teamPickerView.dataSource = self

        // Campo de input para o time
        teamInputField = UITextField()
        teamInputField.placeholder = "Time"
        teamInputField.borderStyle = .none
        teamInputField.inputView = teamPickerView
        teamInputField.delegate = self
        teamInputField.isUserInteractionEnabled = true
        teamInputField.translatesAutoresizingMaskIntoConstraints = false

        // Adicionando uma visualização para a borda inferior
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.systemGray3
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        teamInputField.addSubview(bottomLine)
        
        NSLayoutConstraint.activate([
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            bottomLine.leadingAnchor.constraint(equalTo: teamInputField.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: teamInputField.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: teamInputField.bottomAnchor, constant: 10)
        ])

        nameTextField = createTextFieldWithBottomBorder(placeholder: "Nome")
        numberTextField = createTextFieldWithBottomBorder(placeholder: "Número")
        
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
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, teamInputField, nameTextField, numberTextField, buttonStackView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 30
        
        view.addSubview(stackView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func createTextFieldWithBottomBorder(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
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
        
        isRightHand = true
    }

    @objc func leftButtonTapped() {
        leftButton.backgroundColor = .systemBlue
        leftButton.setTitleColor(.white, for: .normal)
        
        rightButton.backgroundColor = .white
        rightButton.setTitleColor(.systemBlue, for: .normal)
        rightButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        isRightHand = false
    }

    @objc func addButtonTapped() {
        guard let team = teamInputField.text, !team.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let number = numberTextField.text, !number.isEmpty else {
            let alert = UIAlertController(title: "Erro", message: "Preencha todos os campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Cria um novo Player usando o ManagerPlayer
        ManagerPlayer.shared.createPlayer(name: name, team: team, number: number, isRightHand: isRightHand)
        
        teamInputField.text = ""
        nameTextField.text = ""
        numberTextField.text = ""
        isRightHand = true

        rightButtonTapped()
        
        if let tabBarController = self.tabBarController as? UserTabBarController {
            tabBarController.selectedIndex = 1
        }
        
        // Notificar o usuário que o jogador foi adicionado com sucesso
        let successAlert = UIAlertController(title: "Sucesso", message: "Jogador adicionado com sucesso!", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(successAlert, animated: true, completion: nil)
    }
    
    // MARK: - UIPickerViewDelegate, UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teams.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teams[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        teamInputField.text = teams[row]
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Bloqueia qualquer alteração no texto
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // Permite que o pickerView seja mostrado
        return true
    }
}
