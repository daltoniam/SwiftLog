//////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Log.swift
//
//  Created by Dalton Cherry on 12/23/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
//  Simple logging class.
//////////////////////////////////////////////////////////////////////////////////////////////////

import Foundation

///The log class containing all the needed methods
public class Log {
    
    ///The max size a log file can be in Kilobytes. Default is 1024 (1 MB)
    public var maxFileSize = 1024
    
    ///The max number of log file that will be stored. Once this point is reached, the oldest file is deleted.
    public var maxFileCount = 4
    
    ///The directory in which the log files will be written
    public var directory = Log.defaultDirectory()
    
    //The name of the log files.
    public var name = "logfile"
    
    ///logging singleton
    public class var logger: Log {
        
        struct Static {
            static let instance: Log = Log()
        }
        return Static.instance
    }
    ///write content to the current log file.
    public func write(text: String) -> NSError? {
        let path = "\(directory)/\(logName(0))"
        var error: NSError?
        text.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
        cleanup()
        return error
    }
    ///do the checks and cleanup
    func cleanup() {
        let path = "\(directory)/\(logName(0))"
        let size = fileSize(path)
        let maxSize = maxFileSize*1024
        if size > 0 && size >= maxSize && maxSize > 0 && maxFileCount > 0 {
            rename(0)
            //delete the oldest file
            let deletePath = "\(directory)/\(logName(maxFileCount))"
            let fileManager = NSFileManager.defaultManager()
            fileManager.removeItemAtPath(deletePath, error: nil)
        }
    }
    ///check the size of a file
    func fileSize(path: String) -> Int {
        let fileManager = NSFileManager.defaultManager()
        let attrs = fileManager.attributesOfFileSystemForPath(path, error: nil)
        if let size = attrs?[NSFileSize] as? Int {
            return size
        }
        return 0
    }
    
    ///Recursive method call to rename log files
    func rename(index: Int) {
        let fileManager = NSFileManager.defaultManager()
        let path = "\(directory)/\(logName(index))"
        let newPath = "\(directory)/\(logName(index+1))"
        if fileManager.fileExistsAtPath(newPath) {
            rename(index+1)
        }
        fileManager.moveItemAtPath(path, toPath: newPath, error: nil)
    }
    
    ///gets the log name
    func logName(num :Int) -> String {
        return "\(name)-\(num).log"
    }
    
    ///get the default log directory
    class func defaultDirectory() -> String {
        var path = ""
        #if os(iOS)
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            path = "\(paths[0])/Logs"
        #elseif os(OSX)
            let fileManager = NSFileManager.defaultManager()
            let urls = fileManager.URLsForDirectory(.LibraryDirectory, inDomains: .UserDomainMask)
            if let url = urls.last as? NSURL {
                if let path = url.path {
                    path = "\(path)/Logs"
                }
            }
        #endif
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(path) && path != ""  {
            fileManager.createDirectoryAtPath(path, withIntermediateDirectories: false, attributes: nil, error: nil)
        }
        return path
    }
    
}

///a free function to make writing to the log much nicer
func logf(text: String) {
    Log.logger.write(text)
}