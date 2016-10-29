//
//  XMLParser.swift
//  weather
//
//  Created by Xuanyu Wang on 2016-10-29.
//
//

import Foundation

// 1. define protocal
protocol XMLParserDelegate: class {
    func didFinishTask(sender: XMLParser)
}

class XMLParser: NSObject, NSXMLParserDelegate {
    var currentElement = "" // current element during parsing
    var contentOfCurrentElement = ""
    var contentOfTitle = [String]()
    var weatherInfo: [String: String] = [String: String]()
    
    // 2. define delegate variable
    weak var delegate:XMLParserDelegate?
    
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
    
    func putInDict(){
        for item in contentOfTitle{
            var suffixBeginning = item.characters.indexOf(":")
            if  suffixBeginning != nil {
                let prefix = item.substringToIndex(suffixBeginning!)
                suffixBeginning = suffixBeginning?.advancedBy(2)
                let suffix = item.substringFromIndex(suffixBeginning!)
                
                weatherInfo[prefix] = suffix
            }
        }
    }
    
    // called every time the parser finds a </key>
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if currentElement == "title" {
            contentOfTitle.append(contentOfCurrentElement)
//            print(contentOfCurrentElement)
        }
        contentOfCurrentElement = ""
        currentElement = ""
    }
    
    // called when the parser finished the document
    func parserDidEndDocument(parser: NSXMLParser) {
        // 5. calling delegate method
        putInDict()
        delegate?.didFinishTask(self)
    }
    
}
