//
//  File.swift
//  GiphyAppTests
//
//  Created by Dzmitry Tarelkin on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest

@testable import GiphyApp

class File: XCTestCase {
    var fileManager: AppFileManager?
    
    override func setUp() {
        super.setUp()
        self.fileManager = AppFileManager()
    }
    
    override func tearDown() {
        self.fileManager = nil
        super.tearDown()
    }
    
    
    //getFileName
    func test_getFilename_Success()  {
        let fileName = self.fileManager?.getFilename(name: "File", type: "gif")
        let trueString = "File.gif"
        XCTAssertEqual(fileName, trueString)
    }
    
    //getFullPath
    func test_getFullPath_Success() {
        let fullPath = self.fileManager?.getFullPath(folder: "folder", filename: "fileName")
        let truePath = "folder/fileName"
        XCTAssertEqual(fullPath, truePath)
    }
    
    //createFile
    func test_createFile_Success() {
        let data = Data()
        let filename = "file"
        self.fileManager?.createFile(filename, data: data, folder: AppFileManager.previewsPath)
        let success = FileManager.default.fileExists(atPath: (self.fileManager?.getFullPath(folder: AppFileManager.previewsPath, filename: filename))!)
        XCTAssertTrue(success)
    }

    //dataFromFile
    func test_getDataFromFile_Success() {
        let data = Data()
        let fileName = "file"
        let folder = AppFileManager.previewsPath
        
        //create file
        self.fileManager?.createFile(fileName, data: data, folder: folder)
        //check
        let requestData = self.fileManager?.dataFromFile(filename: fileName, folder: folder)
        
        XCTAssertEqual(data, requestData)
    }
}
