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
    var xmlofwebsite:String!
    
    @IBOutlet weak var detaillabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xmlParser.delegate = self
        // Do any additional setup after loading the view.
        if xmlofwebsite == nil{
            detaillabel.text = "aha"
        }
        else{
            url = try! NSURL(string: xmlofwebsite)!
            xmlParser.startParsingWithContentsOfURL(url)
        }
        
        
        
    }
    func didFinishTask(sender: XMLParser) {
        detaillabel.text = xmlParser.weatherSummary["Current Conditions"]
        print(xmlParser.weatherInfo)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "passSelectedLocation"
//            && location != nil{
//            let mainVC: ViewController = segue.destinationViewController as! ViewController
//            
//            mainVC.currentLocation = location
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
