//
//  Categorie.swift
//  todoey
//
//  Created by Mohamed AbouElkhair on 7/22/19.
//  Copyright © 2019 Mohamed Abo Elkhair. All rights reserved.
//

import Foundation
import RealmSwift

class Categorie: Object {
     @objc dynamic var  name: String = ""
     let items = List<Item>()
}
