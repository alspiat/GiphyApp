//
//  FileManager.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/28/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

fileprivate let previewsDirectory = "Previews"
fileprivate let originalsDirectory = "Originals"

@objcMembers class AppFileManager: NSObject {
    
    private let fileManager: FileManager!
    
    static let previewsPath = "\(NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0])/\(previewsDirectory)"
    static let originalsPath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(originalsDirectory)"
    
    override init() {
        self.fileManager = FileManager.default
        super.init()

        self.createDirectoriesIfNeeded()
    }
    
    func createDirectoriesIfNeeded() {
        try? self.fileManager.createDirectory(atPath: AppFileManager.previewsPath, withIntermediateDirectories: true, attributes: nil)
        try? self.fileManager.createDirectory(atPath: AppFileManager.originalsPath, withIntermediateDirectories: true, attributes: nil)
    }
    
    func getFilename(name: String, type: String) -> String? {
        return "\(name).\(type)"
    }
    
    func getFullPath(folder: String, filename: String) -> String {
        return "\(folder)/\(filename)"
    }
    
    func createFile(_ fileName: String, data: Data, folder: String) {
        let filepath = self.getFullPath(folder: folder, filename: fileName)
        self.fileManager.createFile(atPath: filepath, contents: data, attributes: nil)
    }
    
    func dataFromFile(filename: String, folder: String) -> Data? {
        let filepath = self.getFullPath(folder: folder, filename: filename)
        let url = URL(fileURLWithPath: filepath)
        return try? Data(contentsOf: url)
    }
    
    func clearPreviewsCache(from rootDirectory: String) -> Bool {
        do {
            try self.fileManager.removeItem(atPath: AppFileManager.previewsPath)
            return true
        } catch {
            return false
        }
    }
    
    func removeFile(_ fileName: String, folder: String) -> Bool {
        let filepath = self.getFullPath(folder: folder, filename: fileName)
        do {
            try self.fileManager.removeItem(atPath: filepath)
            return true
        } catch {
            return false
        }
    }
    
}
