//
//  ViewController.swift
//  PlistSearch
//
//  Created by Saideep Reddy Talusani on 9/9/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var stateData = [String]()
    var filterData = [String]()
    var stateModel: Model?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    func initialSetup(){
        tableView.dataSource = self
        searchbar.delegate = self
        let path = Bundle.main.path(forResource: "PList", ofType: "plist")
        let dic = NSDictionary(contentsOfFile: path!)
        let state = dic?.object(forKey:"States") as! [String]
        print(state)
        stateModel = Model(data: state)
        stateData = stateModel?.data ?? []
        print(stateData)
        filterData = self.stateData
    }
}
extension ViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filterData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "DemoCell", for: indexPath) as! DemoCell
            cell.dataLabel.text = filterData[indexPath.row]
            return cell
        }
    }
    extension ViewController: UISearchBarDelegate{
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty{
                self.filterData = self.stateData
                self.tableView.reloadData()
                return
            }
            self.filterData = self.stateData.filter{ return $0.contains(searchText)}
            self.tableView.reloadData()
        }
    }

