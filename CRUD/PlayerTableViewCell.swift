//
//  PlayerTableViewCell.swift
//  CRUD
//
//  Created by Gustavo Kamitani on 08/08/24.
//

import Foundation
import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    let playerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let playerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let playerSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let arrowIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(playerImageView)
        addSubview(playerNameLabel)
        addSubview(playerSubtitleLabel)
        addSubview(arrowIconView)
        
        NSLayoutConstraint.activate([
            playerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            playerImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playerImageView.widthAnchor.constraint(equalToConstant: 40),
            playerImageView.heightAnchor.constraint(equalToConstant: 40),
            
            playerNameLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 16),
            playerNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            playerNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            playerSubtitleLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 16),
            playerSubtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            playerSubtitleLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 4),
            playerSubtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            arrowIconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowIconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            arrowIconView.widthAnchor.constraint(equalToConstant: 18),
            arrowIconView.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func configure(with player: Player) {
        playerNameLabel.text = player.name
        playerSubtitleLabel.text = "Número: \(player.number ?? "N/A")"
        
        if let teamName = player.team?.lowercased() {
               playerImageView.image = UIImage(named: teamName)
           } else {
               playerImageView.image = UIImage(named: "defaultImageName")
           }
    }
}
