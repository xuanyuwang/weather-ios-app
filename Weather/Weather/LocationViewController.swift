//
//  LocationViewController.swift
//  weather
//
//  Created by 王泽文 on 10/29/16.
//  Copyright © 2016 Xuanyu Wang. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var location: selectedLocations!
    var items = [String]()
    var result = [String]()
    var csvParser = CSVParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseFeeds()
        print(csvParser.locations)
        self.items = csvParser.locations
        self.result = self.items
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.placeholder = "Search"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func parseFeeds(){
        csvParser.readFile(csvParser.feedsPath!)
        csvParser.parse()
        print(csvParser.xmlInfo)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identify: String = "cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = self.result[indexPath.row]
        
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("[ViewController searchBar] searchText: \(searchText)")
        
        // 没有搜索内容时显示全部内容
        if searchText == "" {
            self.result = self.items
        } else {
            
            // 匹配用户输入的前缀，不区分大小写
            self.result = []
            
            for arr in self.items {
                if arr.lowercaseString.hasPrefix(searchText.lowercaseString) {
                    self.result.append(arr)
                }
            }
        }
        
        // 刷新tableView 数据显示
        self.tableView.reloadData()
    }
    
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        
        searchBar.resignFirstResponder()
    }
    
    // 书签按钮触发事件
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        
        print("搜索历史")
    }
    
    // 取消按钮触发事件
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // 搜索内容置空
        searchBar.text = ""
        self.result = self.items
        self.tableView.reloadData()
    }
//    @IBAction func sendLocation(sender: UIButton) {
//        location = selectedLocations()
//        location.location = csvParser.locations[2]
//        location.website = csvParser.xmlInfo[location.location]!
//        self.performSegueWithIdentifier("passSelectedLocation", sender: location)
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "passSelectedLocation"
        && location != nil{
            let mainVC: ViewController = segue.destinationViewController as! ViewController
            
            mainVC.currentLocation = location
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        location = selectedLocations()
        location.location = items[indexPath.row]
        location.website = csvParser.xmlInfo[location.location]!
        performSegueWithIdentifier("passSelectedLocation", sender: location.location)
    }
    
    
    
    
    
    
    
}
