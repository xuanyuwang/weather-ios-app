//
//  CSVParser.swift
//  Weather
//
//  Created by Xuanyu Wang on 2016-10-29.
//  Copyright © 2016 Xuanyu Wang. All rights reserved.
//

import Foundation

class CSVParser: NSObject{
    var xmlInfo = Dictionary<String, String>()
    let feedsPath = NSBundle.mainBundle().pathForResource("feeds", ofType: "csv")
    var lines = [String]()
    var locations = [String]()
    
    func splitIntoThreeParts(line: String){
        var content = line
        var DelimiterIndex = content.characters.indexOf(",")
        let website = content.substringToIndex(DelimiterIndex!)
        DelimiterIndex = DelimiterIndex?.advancedBy(2)
        content = content.substringFromIndex(DelimiterIndex!)
        let location = content
        xmlInfo[location] = website
        locations.append(location)
    }
    
    func readFile(path: String) -> Array<String> {
        do {
            let contents:NSString = try NSString(contentsOfFile: path, encoding: NSASCIIStringEncoding)
            contents.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet()).enumerateLines{line,stop in self.lines.append(line)}
            return lines
        } catch {
            print("Unable to read file: \(path)");
            return [String]()
        }
    }
    
    func parse(){
        for testItem in lines {
            splitIntoThreeParts(testItem)
        }
    }
    
}