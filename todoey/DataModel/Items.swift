//
//  Items.swift
//  todoey
//
//  Created by Mohamed Abo Elkhair on 6/19/19.
//  Copyright © 2019 Mohamed Abo Elkhair. All rights reserved.
//

import Foundation


class Item : Encodable, Decodable {
    var titel: String    = ""
    var done : Bool = false
    
}
