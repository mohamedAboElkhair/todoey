//
//  TodoList.swift
//  todoey
//
//  Created by Mohamed AbouElkhair on 7/22/19.
//  Copyright © 2019 Mohamed Abo Elkhair. All rights reserved.
//

import Foundation
import RealmSwift


class Item: Object {
   @objc dynamic var title : String = ""
   @objc dynamic var done : Bool =  false
   @objc dynamic var dateCreated : Date?
   var idCate = LinkingObjects(fromType: Categorie.self, property: "items")
    
}
