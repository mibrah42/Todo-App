//
//  Category.swift
//  Todoey
//
//  Created by Mohamed Ibrahim on 2017-12-25.
//  Copyright © 2017 Mohamed Ibrahim. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    var items = List<Item>()
}
