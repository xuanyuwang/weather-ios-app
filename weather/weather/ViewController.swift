//
//  ViewController.swift
//  weather
//
//  Created by Xuanyu Wang on 2016-10-29.
//
//

import UIKit

// 3. implement delegate
class ViewController: UIViewController, XMLParserDelegate,UITableViewDelegate,UITableViewDataSource {
    var url = NSURL()
    var xmlParser = XMLParser()
    var currentLocation: selectedLocations!
    var results = [String]()
   // var locationz:selectedLocations!
    @IBOutlet weak var currentCondition: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        // 4. set delegate
        xmlParser.delegate = self
        
        if currentLocation == nil{
            currentCondition.text = "Please Select Your Location"
        }else{
            url = try! NSURL(string: currentLocation.website)!
            xmlParser.startParsingWithContentsOfURL(url)
            
            //display on tableview
            self.results = xmlParser.contentOfTitle
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    @IBAction func detailbtn(sender: AnyObject) {
        performSegueWithIdentifier("showDetail", sender: currentLocation.location)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // implement delegate
    func didFinishTask(sender: XMLParser) {
        currentCondition.text = xmlParser.weatherInfo["Current Conditions"]
        print(xmlParser.weatherInfo["Current Conditions"])
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"{
            let detailVC:ShowDetailViewController = segue.destinationViewController as! ShowDetailViewController
            detailVC.xmlofwebsite = currentLocation.website
           
        }
    }
    ////////////////////////////// Table View /////////////////////////////////
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify: String = "cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = self.results[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
}
