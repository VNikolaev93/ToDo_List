//
//  Model.swift
//  ToDo_List
//
//  Created by Beulah Sharna on 11/09/2019.
//  Copyright © 2019 VNikolaev93. All rights reserved.
//

import Foundation

var ToDoList: [[String:Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let arr = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String:Any]] {
            return arr
        } else {
            return []
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool = false) {
    ToDoList.append(["Name" : nameItem, "isCompleted" : false])
}

func removeItem(at index: Int) {
    ToDoList.remove(at: index)
}

func moveItem(fromIndex: Int, toIndex: Int) {
    let from = ToDoList[fromIndex]
    ToDoList.remove(at: fromIndex)
    ToDoList.insert(from, at: toIndex)
}

func changeState(at item: Int) -> Bool {
    ToDoList[item]["isCompleted"] = !(ToDoList[item]["isCompleted"] as! Bool)
    return ToDoList[item]["isCompleted"] as! Bool

}
