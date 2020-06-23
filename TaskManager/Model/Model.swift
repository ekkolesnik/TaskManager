//
//  Model.swift
//  TaskManager
//
//  Created by Evgeny Kolesnik on 23.06.2020.
//  Copyright © 2020 Evgeny Kolesnik. All rights reserved.
//

import Foundation

var pathForSaveData: String {
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.plist"
    print(path)
    return path
}

var rootItem: Task?

func loadData() {
    if let dict = NSDictionary(contentsOfFile: pathForSaveData) {
        rootItem = Task(dictionary: dict)
    } else {
        rootItem = Task(nameTask: "TaskManager")
    }
}

func saveData() {
    rootItem?.dictionary.write(toFile: pathForSaveData, atomically: true)
}
    
