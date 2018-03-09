//
//  SwiftLogTests.swift
//  SwiftLogTests
//
//  Created by Dalton Cherry on 1/5/15.
//  Copyright (c) 2015 vluxe. All rights reserved.
//

import XCTest
import SwiftLog

class SwiftLogTests: XCTestCase {
    
    var logFilePath: String {
        return Log.logger.currentPath
    }
    
    override func setUp() {
        super.setUp()
        Log.logger.name = "testlogfile"
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: Log.logger.directory)
            for fileName in files {
                let path = "\(Log.logger.directory)/\(fileName)"
                try FileManager.default.removeItem(atPath: path)
            }
        } catch {
            //does nothing, because the file might not be there
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogging() {
        logw("write to the log!")
        XCTAssert(FileManager.default.fileExists(atPath: logFilePath), "File should exist when written to")
    }
    
    func testRolling() {
        for i in 1..<90000 {
            logw("\(i) bottles of beer on the wall")
        }
        do {
        let fileCount = try FileManager.default.contentsOfDirectory(atPath: Log.logger.directory).count
            print("file count is: \(fileCount)")
        XCTAssert((fileCount <= Log.logger.maxFileCount), "The rolling did not work. More files than expected")
        } catch {
            XCTFail("Unable to count the files in \(Log.logger.directory)")
        }
    }
    
}
