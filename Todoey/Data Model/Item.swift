//
//  Item.swift
//  Todoey
//
//  Created by Mohamed Ibrahim on 2017-12-25.
//  Copyright © 2017 Mohamed Ibrahim. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
