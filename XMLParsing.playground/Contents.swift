import UIKit
import Foundation
import XCPlayground

// By default Playgrounds execute the code in each page, from top-to-bottom,
// then they stop executing.
// By setting the needsIndefiniteExecution to be true,
// we allow any asynchronous code we have in our Playground to continue running indefinitely.
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


class XMLParser: NSObject, NSXMLParserDelegate {
    var currentElement = "" // current element during parsing
    var contentOfCurrentElement = ""
    var dict: Dictionary<String, String> = Dictionary<String, String>()    
    
    func startParsingWithContentsOfURL(rssURL: NSURL) {
        let parser = NSXMLParser(contentsOfURL: rssURL)
        parser!.delegate = self
        parser!.parse()
    }
    
    // called every time the parser finds a <key>
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //print(elementName)
        currentElement = elementName
    }
    
    //called every time the parser enters a <key> and it will stop on line breaks
    func parser(parser: NSXMLParser, foundCharacters str: String) {
        if currentElement == "title" {
            contentOfCurrentElement += str
        }
        
    }

    // called every time the parser finds a </key>
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if currentElement == "title" {
            print(contentOfCurrentElement)
        }
       currentElement = ""
        contentOfCurrentElement = ""
    }
    
    
    
    // called when the parser finished the document
    func parserDidEndDocument(parser: NSXMLParser) {
        print("parse has ended")
    }
    
}

let url = NSURL(string: "https://weather.gc.ca/rss/city/ns-19_e.xml")
var xmlParser = XMLParser()
xmlParser.startParsingWithContentsOfURL(url!)
