//
//  TodoListItem.swift
//  Todoey
//
//  Created by Shikhar Kumar on 2/6/20.
//  Copyright © 2020 Shikhar Kumar. All rights reserved.
//

import Foundation

class TodoListItem: Codable {
    var itemTitle: String
    var done: Bool = false
    
    init(itemTitle: String) {
        self.itemTitle = itemTitle
    }
    
    init(itemTitle: String, done: Bool) {
        self.itemTitle = itemTitle
        self.done = done
    }
}
