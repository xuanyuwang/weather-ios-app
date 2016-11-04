//
//  ShowDetailViewController.swift
//  weather
//
//  Created by 王泽文 on 11/3/16.
//  Copyright © 2016 Xuanyu Wang. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController,XMLParserDelegate {
    var url = NSURL()
    var xmlParser = XMLParser()
    var dataToDetails: passToDetails!
    
    @IBOutlet weak var detaillabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xmlParser.delegate = self
        // Do any additional setup after loading the view.
        if dataToDetails == nil{
            detaillabel.text = "aha"
        }
        else{
            url = try! NSURL(string: dataToDetails.website)!
            xmlParser.startParsingWithContentsOfURL(url)
        }
    }
    
    func didFinishTask(sender: XMLParser) {
        detaillabel.text = xmlParser.weatherSummary[dataToDetails.timePeriod]
        print(xmlParser.weatherSummary[dataToDetails.timePeriod])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
