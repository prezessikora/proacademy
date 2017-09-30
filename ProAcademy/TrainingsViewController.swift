//
//  TrainingsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 30/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

struct Training {
    let title: String
    let trainer: String
    
}

class TrainingsViewController: UITableViewController {

    let trainings = [Training(title: "CAT EYES",trainer: "Jagoda Wrześniewska"),Training(title: "PERFEKCYJNE BRWI",trainer: "Krzysztof Sikora"),
                     Training(title: "ZMYSŁOWE USTA",trainer: "Sandra Sikora")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-Home-48"), style: .plain, target: nil , action: nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageFrom(systemItem: .search), style: .plain, target: nil , action: nil)
        
        self.navigationItem.titleView = UIImageView(image:  UIImage(named: "pa_title"))

    }
    
    
    
    func imageFrom(systemItem: UIBarButtonSystemItem)-> UIImage? {
        let tempItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: nil, action: nil)
        
        // add to toolbar and render it
        UIToolbar().setItems([tempItem], animated: false)
        
        // got image from real uibutton
        let itemView = tempItem.value(forKey: "view") as! UIView
        for view in itemView.subviews {
            if let button = view as? UIButton, let imageView = button.imageView {
                return imageView.image
            }
        }
        
        return nil
    }


}

extension TrainingsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingCell") as! TrainingTableViewCell
        cell.title.text = trainings[indexPath.row].title
        cell.trainer.text = trainings[indexPath.row].trainer
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    
    }
    
}

