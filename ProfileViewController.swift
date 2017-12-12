//
//  ProfileViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 28/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class ProfileViewController: TabBasedViewController, UITableViewDataSource {

    fileprivate var trainigs: MyTrainingsService {
        get {
            return Utils.application().myTrainings
        }
    }
    
    let cellReuseIdentifier = "TrainingProfileCell"
    
    var upcomingTab: Tab!
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var upcomingBar: UIView!
    
    var attendedTab: Tab!
    @IBOutlet weak var attendedButton: UIButton!    
    @IBOutlet weak var attendedBar: UIView!
 
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        upcomingTab = Tab(button: upcomingButton, bar: upcomingBar)
        attendedTab = Tab(button: attendedButton, bar: attendedBar)
        
        changeState(active: upcomingTab, inactive: attendedTab)

        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func onUpcoming(_ sender: Any) {
        changeState(active: upcomingTab, inactive: attendedTab)
        tableView.reloadData()
    }
    
    @IBAction func onAttended(_ sender: Any) {
        changeState(active: attendedTab, inactive: upcomingTab)
        tableView.reloadData()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = upcomingTab.active ? trainigs.upcomingTrainings() : trainigs.attendedTrainings()

        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = upcomingTab.active ? trainigs.upcomingTrainings() : trainigs.attendedTrainings()
        
        let training = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! TrainingProfileTableViewCell
        cell.trainingTitle.text = training.title
        cell.trainer.text = training.trainer
        cell.training = training
        cell.showDetails.setImage(UIImage(named: "right arrow"), for: .normal)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
    
}

