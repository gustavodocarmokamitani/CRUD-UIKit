//
//  ListPlayerViewController.swift
//  CRUD
//
//  Created by Gustavo Kamitani on 08/08/24.
//

import Foundation
import UIKit
import CoreData

class ListPlayerViewController: UIViewController {

    var filteredPlayers: [Player] = []
    var isSearching = false
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Buscar jogador"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerCell")
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPlayers()
    }   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        configureNavigationBar()
        configureUIElements()
        fetchPlayers()
    }
    
    func configureNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = ""
        navigationItem.titleView = titleLabel
    }
    
    func configureUIElements() {
        let titleLabel = UILabel()
        titleLabel.text = "Jogadores"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .darkText
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Selecione o jogador para iniciar o score board."
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        
        searchBar.delegate = self
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
           
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            searchBar.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func fetchPlayers() {
        let manager = ManagerPlayer.shared
        filteredPlayers = manager.fetchAllPlayers()
        tableView.reloadData()
    }
}

extension ListPlayerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredPlayers.count : filteredPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell else {
            return UITableViewCell()
        }
        let player = isSearching ? filteredPlayers[indexPath.row] : filteredPlayers[indexPath.row]
        cell.configure(with: player)
        return cell
    }
    
    // Método para permitir a exclusão ao deslizar
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Obtenha o jogador que deve ser excluído
            let playerToDelete = filteredPlayers[indexPath.row]
            
            // Remova o jogador do Core Data
            ManagerPlayer.shared.deletePlayer(player: playerToDelete)
            
            // Atualize a lista filtrada
            filteredPlayers.remove(at: indexPath.row)
            
            // Remova a linha da tabela
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ListPlayerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedPlayer = isSearching ? filteredPlayers[indexPath.row] : filteredPlayers[indexPath.row]
        let scoreboardVC = EditPlayerViewController()
        scoreboardVC.player = selectedPlayer
        navigationController?.pushViewController(scoreboardVC, animated: true)
    }
}

extension ListPlayerViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            fetchPlayers() 
        } else {
            isSearching = true
            filteredPlayers = filteredPlayers.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isSearching = false
        fetchPlayers()
    }
}

