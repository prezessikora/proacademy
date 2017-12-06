//
//  TrainingsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 30/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit


class TrainingsViewController: UITableViewController {
    
    fileprivate var trainigs: TrainingsService {
        get {
            return Utils.application().trainingsService
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-Home-48"), style: .plain, target: nil , action: nil)
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Utils.imageFrom(systemItem: .search), style: .plain, target: nil , action: nil)
        
        self.navigationItem.titleView = UIImageView(image:  UIImage(named: "pa_title"))
        
        // unhide it if returned from reservation
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTrainingDetails" {
            let detailsVC = segue.destination as! TrainingDetailsViewController
            let clickedCell = sender as! TrainingTableViewCell
            if let training = clickedCell.training {
                detailsVC.training = training
            } else {
                print("ERROR - the clicked cell did not have assigned training.")
            }
        }
    }
    
   
}

extension TrainingsViewController {
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = trainigs.allTrainings() {
            return data.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let training = trainigs.allTrainings()![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingCell") as! TrainingTableViewCell
        cell.title.text = training.title
        cell.trainer.text = training.trainer
        cell.training = training
        cell.updateFavouriteState()
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    
    }
    
}

