//
//  Item.swift
//  Todoey
//
//  Created by Michael Abrams on 9/5/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var accessoryIsShowing : Bool = false
    @objc dynamic var timeCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
