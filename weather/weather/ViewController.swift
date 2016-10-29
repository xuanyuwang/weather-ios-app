//
//  ViewController.swift
//  weather
//
//  Created by Xuanyu Wang on 2016-10-29.
//
//

import UIKit

// 3. implement delegate
class ViewController: UIViewController, XMLParserDelegate {
    
    let url = NSURL(string: "https://weather.gc.ca/rss/city/ns-19_e.xml")
    var xmlParser = XMLParser()
    @IBOutlet weak var currentCondition: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 4. set delegate
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // implement delegate
    func didFinishTask(sender: XMLParser) {
//        var allInfo = String()
//        for item in xmlParser.contentOfTitle{
//            allInfo += item
//        }
        currentCondition.text = xmlParser.weatherInfo["Current Conditions"]
        print(xmlParser.weatherInfo)
        
    }
}
