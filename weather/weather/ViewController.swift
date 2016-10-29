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
    var csvParser = CSVParser()
    var url = NSURL()
    var xmlParser = XMLParser()
    @IBOutlet weak var currentCondition: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 4. set delegate
        csv()
        xmlParser.delegate = self
        let province = "Alberta"
        let city = "Banff"
        url = NSURL(string: csvParser.xmlInfo[city]![province]!)!
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
    
    func csv(){
        csvParser.readFile(csvParser.feedsPath!)
        csvParser.parse()
        print(csvParser.xmlInfo)
    }
}
