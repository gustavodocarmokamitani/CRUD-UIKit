//
//  ManagerPlayer.swift
//  CRUD
//
//  Created by Gustavo Kamitani on 08/08/24.
//

import Foundation
import CoreData
import UIKit

class ManagerPlayer {

    static let shared = ManagerPlayer()

    private init() {}

    // Referência ao contexto do Core Data
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    // Função para criar um novo player
    func createPlayer(name: String, team: String, number: String, isRightHand: Bool) {
        let player = Player(context: context)
        player.name = name
        player.team = team
        player.number = number
        player.isRightHand = isRightHand
        
        saveContext()
    }

    // Função para buscar todos os players
    func fetchAllPlayers() -> [Player] {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Erro ao buscar players: \(error)")
            return []
        }
    }

    // Função para deletar um player
    func deletePlayer(player: Player) {
        context.delete(player)
        saveContext()
    }

    // Função para salvar o contexto
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Erro ao salvar contexto: \(error)")
            }
        }
    }
}
