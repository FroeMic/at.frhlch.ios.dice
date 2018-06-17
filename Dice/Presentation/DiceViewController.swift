//
//  File.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit
import Spring

class DiceViewController: UIViewController {
    
    fileprivate static let collectionViewReuseIdentifier = "DiceCollectionViewCell"
    
    @IBOutlet var diceCollectionView: UICollectionView!
    
    private var dice: [Dice] = []
    private let feedbackManager = FeedbackManager()
    private let settings = Injection.settings
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        diceCollectionView.delegate = self
        diceCollectionView.dataSource = self
        diceCollectionView.register(DiceCollectionViewCell.self, forCellWithReuseIdentifier: DiceViewController.collectionViewReuseIdentifier)
        
        Injection.shakeDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dice = []
        for _ in 0...settings.numberOfDice {
            dice.append(Dice())
        }
        
        configureCollectionViewLayout()
        
        diceCollectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        print(diceCollectionView.bounds.width)
        configureCollectionViewLayout(animated: true)
        super.viewDidLayoutSubviews()
        print(diceCollectionView.bounds.width)
        print("viewDidLayoutSubviews")
        configureCollectionViewLayout(animated: true)
//        configureCollectionViewLayout()
    }
    
    
    private func configureCollectionViewLayout(animated: Bool = false) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
    
        let availableWidth = diceCollectionView.bounds.width - layout.minimumInteritemSpacing * 1.0
        
        let cellWidth = availableWidth / 2.0
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        print(diceCollectionView.bounds.width)
        print(layout.minimumInteritemSpacing)
        print(cellWidth)
        
        diceCollectionView.setCollectionViewLayout(layout, animated: animated)
    }


    @objc
    fileprivate func rollDice() {
        
        for die in dice {
            die.roll()
        }
        
        for i in 0...dice.count {
            if let cell = diceCollectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? DiceCollectionViewCell {
                cell.updateDiceImage(dice[i].result.image, animated: true)
            }
        }
        
        print(settings.numberOfDice)
        
        // TODO: Update to save image for all possible results
        if settings.numberOfDice == 1 {
            let result = DiceResult(result: dice[0].result, time: Date())
            Injection.diceHistoryStore.store(result)
        }
        
        feedbackManager.feedbackForDice(success: true)
    }
}

// MARK: ShakeDelegate
extension DiceViewController: ShakeDelegate {
    
    func shakeEnded() {
        rollDice()
    }
}

extension DiceViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rollDice()
    }
    
}

extension DiceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dice.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiceViewController.collectionViewReuseIdentifier, for: indexPath)
        
        if let cell = cell as? DiceCollectionViewCell {
            cell.updateDiceImage(dice[indexPath.row].result.image, animated: false)
        }
        
        return cell
        
    }
    
    
}


