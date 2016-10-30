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
    var url = NSURL()
    var xmlParser = XMLParser()
    @IBOutlet weak var currentCondition: UILabel!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        // 4. set delegate
        xmlParser.delegate = self
//        url = NSURL(string: csvParser.xmlInfo[city]![province]!)!
        xmlParser.startParsingWithContentsOfURL(url)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // implement delegate
    func didFinishTask(sender: XMLParser) {
        currentCondition.text = xmlParser.weatherInfo["Current Conditions"]
        print(xmlParser.weatherInfo)
    }
    
}
