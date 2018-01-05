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
            return WordpressService.sharedInstance
        }
    }
    
    var indicator: UIActivityIndicatorView!
    
    var shouldRefreshData = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateOnProductsReload), name: .ProductsDownload, object: nil)
        
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = view.center
        view.addSubview(indicator)
        tableView.tableFooterView = UIView(frame: .zero)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-Home-48"), style: .plain, target: nil , action: nil)
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Utils.imageFrom(systemItem: .search), style: .plain, target: nil , action: nil)
        
        self.navigationItem.titleView = UIImageView(image:  UIImage(named: "pa_title"))
        
        // unhide it if returned from reservation
        self.tabBarController?.tabBar.isHidden = false
        
        // show the activity indicator only when loading
        if trainigs.availableTrainings()?.count == 0 {
            indicator.isHidden = false
            indicator.bringSubview(toFront: view)
            indicator.startAnimating()
        }
        
        // skip first view display reload
        if (shouldRefreshData) {
            trainigs.loadOrRefreshData()
        } else {
            shouldRefreshData = true
        }
        
    }
    
    @objc func updateOnProductsReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }        
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
        if let data = trainigs.availableTrainings() {
            return data.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let training = trainigs.availableTrainings()![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingCell") as! TrainingTableViewCell
        cell.title.text = training.title
        cell.trainer.text = training.trainer
        cell.priceButton.setTitle(formatPrice(of: training), for: .normal)
        cell.priceButton.titleEdgeInsets = priceButtonInsets()
        
        
        cell.availablePlaces.text = formatAvailablePlaces(of: training)
        cell.training = training
        cell.updateFavouriteState()
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    
    }
    
}

