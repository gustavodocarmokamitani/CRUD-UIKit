//
//  UseTabBarController.swift
//  CRUD
//
//  Created by Gustavo Kamitani on 08/08/24.
//

import Foundation
import UIKit

class UserTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabs()
    }
    
    private func configureTabs() {
        let vc1 = CreateUserViewController()
        let vc2 = ListPlayerViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "person.badge.plus")
        vc2.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard")
        
        vc1.title = "Adicionar jogador"
        vc2.title = "Lista dos jogadores"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6
        
        setViewControllers([nav1, nav2], animated: true)
    }
}
