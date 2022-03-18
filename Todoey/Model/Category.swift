//
//  Category.swift
//  Todoey
//
//  Created by Michael Abrams on 9/5/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var hexColor : String = ""
    let items = List<Item>()
}
