//
//  HistoryViewController.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private static let showSettingSegueIdentifier = "showSettingsSegue"
    private static let dequeueHistoryCellIdentifier = "diceHistoryTableViewCell"
    
    private var expanded = false
    private var diceHistory: [DiceResult] = []
    
    @IBOutlet var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
        
        historyTableView.rowHeight = 60.0
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        initTableData()
        registerDiceHistoryObserver()
    }
    
    private func styleView() {
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 10.0)
    }
    
    private func initTableData() {
        diceHistory = Injection.diceHistoryStore.get()
    }
    
    private func registerDiceHistoryObserver() {
        Injection.diceHistoryStore.subscribe(self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        
        if expanded {
            showSettingsScene()
        } else {
            // expand and then switch to settings
        }
    }
    
    private func showSettingsScene() {
        performSegue(withIdentifier: HistoryViewController.showSettingSegueIdentifier, sender: nil)
    }
    
}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diceHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryViewController.dequeueHistoryCellIdentifier, for: indexPath)
        if let diceHistoryCell = cell as? DiceHistoryTableViewCell {
            diceHistoryCell.diceResult = diceHistory[indexPath.row]
        }
        
        return cell
    }
}

extension HistoryViewController: DiceHistoryObserver {
    func update(_ diceResult: DiceResult) {
        diceHistory.insert(diceResult, at: 0)
        
        historyTableView.reloadData()
        
        // update the cell content for all cells to show the proper time string
        for row in 0...diceHistory.count {
            let indexPath = IndexPath(row: row, section: 0)
            let cellAtIndex = historyTableView.cellForRow(at: indexPath)
            if let diceHistoryCell = cellAtIndex as? DiceHistoryTableViewCell {
                diceHistoryCell.reloadCellContent()
            }
        }
    }
}
