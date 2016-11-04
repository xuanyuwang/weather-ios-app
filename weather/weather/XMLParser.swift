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
    var contentOfSummaryElement = ""
    var contentOfTitle = [String]()
    var contentOfSummary = [String]()
    var contentOfEntry = [[String]]()
    var timePeriod = [String]()
    var weatherInfo: [String: String] = [String: String]()
    var weatherSummary: [String: String] = [String: String]()
    
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
        if currentElement == "summary" {
            contentOfSummaryElement += str
        }
    }
    
    func putInDict(){
        for var x in 0..<contentOfSummary.count {
            contentOfEntry.append([contentOfTitle[x + 1], contentOfSummary[x]])
        }
        print("content of entry")
        print(contentOfEntry)
        contentOfEntry.append(contentOfTitle)
        contentOfEntry.append(contentOfSummary)
        
        for item in contentOfEntry{
            var prefix: String = "", suffix: String = ""
            var summary: String = ""
            //process the content of title
            var suffixBeginning = item[0].characters.indexOf(":")
            if  suffixBeginning != nil {
                prefix = item[0].substringToIndex(suffixBeginning!)
                suffixBeginning = suffixBeginning?.advancedBy(2)
                suffix = item[0].substringFromIndex(suffixBeginning!)
                weatherInfo[prefix] = suffix
            }else{
                prefix = item[0]
                suffix = ""
                weatherInfo[prefix] = suffix
            }
            
            //process the content of summary
            summary = item[1].stringByReplacingOccurrencesOfString("<b>", withString: "")
            summary = summary.stringByReplacingOccurrencesOfString("</b>", withString: "")
            summary = summary.stringByReplacingOccurrencesOfString("<br/>", withString: "\n")
            summary = summary.stringByReplacingOccurrencesOfString(".", withString: "\n")
            summary = summary.stringByReplacingOccurrencesOfString("&deg;C", withString: "ºC")
            
            weatherSummary[prefix] = summary
            
            //store the time Period
            timePeriod.append(prefix)
        }
    }
    
    // called every time the parser finds a </key>
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if currentElement == "title" {
            contentOfTitle.append(contentOfCurrentElement)
//            print(contentOfCurrentElement)
        }
        if currentElement == "summary" {
            contentOfSummary.append(contentOfSummaryElement)
        }
        contentOfCurrentElement = ""
        contentOfSummaryElement = ""
        currentElement = ""
    }
    
    // called when the parser finished the document
    func parserDidEndDocument(parser: NSXMLParser) {
        // 5. calling delegate method
        putInDict()
        delegate?.didFinishTask(self)
    }
    
}
