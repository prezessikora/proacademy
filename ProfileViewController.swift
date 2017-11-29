//
//  ProfileViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 28/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit



protocol UserTrainingsService {
    func upcoming() -> [Training]?
    func attended() -> [Training]?
}

class LocalUserTrainingsService: UserTrainingsService {
    
    fileprivate var trainigs: TrainingsService {
        get {
            return Utils.application().trainingsService
        }
    }
    
    func upcoming() -> [Training]? {
        return trainigs.allTrainings()
    }
    
    func attended() -> [Training]? {
        if let justOne = trainigs.allTrainings()?.last {
            return [justOne]
        }
        return nil
    }
    
    
}

class ProfileViewController: TabBasedViewController, UITableViewDataSource {

    let trainings = LocalUserTrainingsService()
    
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
        let data = upcomingTab.active ? trainings.upcoming() : trainings.attended()
        
        if let d = data {
            return d.count
        }
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = upcomingTab.active ? trainings.upcoming() : trainings.attended()
        
        let training = data![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! TrainingProfileTableViewCell
        cell.trainingTitle.text = training.title
        cell.trainer.text = training.trainer
        cell.training = training
        cell.showDetails.setImage(UIImage(named: "right arrow"), for: .normal)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
    
}

