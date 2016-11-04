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
    var dataToDetails: passToDetails!
   // var locationz:selectedLocations!
    @IBOutlet weak var currentCondition: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        // 4. set delegate
        xmlParser.delegate = self
        
        if currentLocation == nil{
            if dataToDetails == nil {
//                currentCondition.text = "Please Select Your Location"
            }else{
                currentLocation = selectedLocations()
                currentLocation.website = dataToDetails.website
                url = try! NSURL(string: currentLocation.website)!
                xmlParser.startParsingWithContentsOfURL(url)
                
                //display on tableview
                //            self.results = xmlParser.contentOfTitle
                self.results = xmlParser.timePeriod
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
            }
        }else{
            url = try! NSURL(string: currentLocation.website)!
            xmlParser.startParsingWithContentsOfURL(url)
            
            //display on tableview
            //            self.results = xmlParser.contentOfTitle
            self.results = xmlParser.timePeriod
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // implement delegate
    func didFinishTask(sender: XMLParser) {
//        currentCondition.text = xmlParser.weatherInfo["Current Conditions"]
        print(xmlParser.weatherInfo["Current Conditions"])
    }
    ////////////////////////////// Table View /////////////////////////////////
    //show items on tableview
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify: String = "cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//        results = results.removeFirst(2)
        let time = self.results[indexPath.row]
        if time != ""{
            let overview = self.xmlParser.weatherInfo[time]
            cell.textLabel?.text = time + ": " + overview!
        }
//        else{
//            cell.textLabel?.text = self.results[indexPath.row]
//        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    //click items to jump
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dataToDetails = passToDetails()
        dataToDetails.timePeriod = results[indexPath.row]
        dataToDetails.website = currentLocation.website
        performSegueWithIdentifier("showDetails", sender: dataToDetails)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" && dataToDetails != nil{
            let detailVC:ShowDetailViewController = segue.destinationViewController as! ShowDetailViewController
            detailVC.dataToDetails = dataToDetails
        }
    }
}
