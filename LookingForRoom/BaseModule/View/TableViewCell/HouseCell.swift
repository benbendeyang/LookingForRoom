//
//  HouseCell.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/29.
//  Copyright © 2018 Zhu. All rights reserved.
//

import UIKit

protocol HouseCellDisplayProtocol {
    var pPicUrl: String { get }
    var pTitle: String { get }
    var pDescribe: String { get }
    var pTags: [Tag] { get }
    var pTotalPrice: String { get }
    var pUnitPrice: String { get }
}

class HouseCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var unitPriceLabel: UILabel!
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    var displayProtocal: HouseCellDisplayProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewLayout.estimatedItemSize = CGSize(width: 40, height: 15)
        tagCollectionView.register(UINib(nibName: "HouseTagCell", bundle: nil), forCellWithReuseIdentifier: "HouseTagCell")
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    open func display(with data: HouseCellDisplayProtocol) {
        displayProtocal = data
        coverImageView.setImage(urlString: data.pPicUrl)
        titleLabel.text = data.pTitle
        describeLabel.text = data.pDescribe
        totalPriceLabel.text = data.pTotalPrice
        unitPriceLabel.text = data.pUnitPrice
    }
}

extension HouseCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let displayProtocal = displayProtocal else { return 0 }
        return displayProtocal.pTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseTagCell", for: indexPath) as! HouseTagCell
        if let displayProtocal = displayProtocal {
            cell.display(tag: displayProtocal.pTags[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let displayProtocal = displayProtocal else { return .zero }
        let width = displayProtocal.pTags[indexPath.row].title.width(fontSize: 11) + 8
        return CGSize(width: width, height: 15)
    }
}
