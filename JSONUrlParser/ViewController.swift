//
//  ViewController.swift
//  JSONUrlParser
//
//  Created by Greeens5 on 02/06/19.
//  Copyright © 2019 Book. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! TableViewCell
        cell.label.text = name [indexPath.row]
        return cell
    }
    @IBOutlet var tableview: UITableView!
    var linkkey = "https://www.myprivatedeal.com/API/getDeals.php?key=jcjn79b8f043f4y74yh48ug984u"
    var name = [String] ()
    override func viewDidLoad() {
        
        let url = URL(string: linkkey)
        URLSession.shared.dataTask(with: url!) {(data,response, error) in
            if error != nil
            {
                print(error!)
            }else{
               
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                    {
                        
                        let myarray = json["Deal"] as! NSArray
                        for arr in myarray
                        {
                            if let path = arr as?[String: Any]
                            {
                                
                                self.name.append(path["title"] as! String)
                                self.name.append(path["distance"] as! String)
                                self.name.append(path["id_deal"] as! String)
                                self.name.append(path["deal_type"] as! String)
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableview.reloadData()
                        }
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
            }.resume()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

