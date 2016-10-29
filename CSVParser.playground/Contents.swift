import UIKit
import Foundation
import XCPlayground

// By default Playgrounds execute the code in each page, from top-to-bottom,
// then they stop executing.
// By setting the needsIndefiniteExecution to be true,
// we allow any asynchronous code we have in our Playground to continue running indefinitely.
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

class CSVParser: NSObject{
    var xmlInfo = Dictionary<String,[String: String]>()
    let feedsPath = NSBundle.mainBundle().pathForResource("feeds", ofType: "csv")
    var lines = [String]()
    
    func splitIntoThreeParts(line: String){
        var content = line
        var DelimiterIndex = content.characters.indexOf(",")
        let website = content.substringToIndex(DelimiterIndex!)
        DelimiterIndex = DelimiterIndex?.advancedBy(2)
        content = content.substringFromIndex(DelimiterIndex!)
        DelimiterIndex = content.characters.indexOf(",")
        let city = content.substringToIndex(DelimiterIndex!)
        DelimiterIndex = DelimiterIndex?.advancedBy(2)
        content = content.substringFromIndex(DelimiterIndex!)
        let province = content
        xmlInfo[city] = [province: website]
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
            csvParser.splitIntoThreeParts(testItem)
        }
    }
    
}


var csvParser = CSVParser()
csvParser.readFile(csvParser.feedsPath!)
csvParser.parse()
print(csvParser.xmlInfo)
