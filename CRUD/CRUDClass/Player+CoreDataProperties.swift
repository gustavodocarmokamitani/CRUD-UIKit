//
//  Player+CoreDataProperties.swift
//  CRUD
//
//  Created by Gustavo Kamitani on 08/08/24.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?
    @NSManaged public var team: String?
    @NSManaged public var number: String?
    @NSManaged public var isRightHand: Bool

}

extension Player : Identifiable {

}
