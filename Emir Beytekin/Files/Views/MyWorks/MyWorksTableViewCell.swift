//
//  MyWorksTableViewCell.swift
//  Emir Beytekin
//
//  Created by Emir Beytekin on 26.10.2017.
//  Copyright © 2017 Emir Beytekin. All rights reserved.
//

import UIKit
import Kingfisher

class MyWorksTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var wObjects: [MyWorks] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "MyWorksCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "MyWorksCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.layoutSubviews()
        
//        self.collectionView.contentInset = UIEdgeInsets(top: -10, left: 25, bottom: 0, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
//extension MyWorksTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
extension MyWorksTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("hayda:: \(wObjects.count)")
        return wObjects.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyWorksCollectionViewCell", for: indexPath) as! MyWorksCollectionViewCell
        if (wObjects.count > 0) {
            let c = wObjects[indexPath.row]
            let url = URL(string: c.logo!)
            cell.worksImage.kf.setImage(with: url)
            cell.backView.dropShadow()
//            cell.worksImage.image =
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let c = wObjects[indexPath.row] as MyWorks
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "collectionClick"), object: nil, userInfo: ["logo":c.logo ?? "", "link":c.link ?? "", "name": c.name ?? "", "desc":c.info ?? ""])
        
    }
    
//    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height);
//    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
////        if(first) {
////            self.sirala()
////            self.first = false
////        }
//
//    }
    
    func sirala() {
        
//        let totals = objects.count
//        let center = round(Double(totals/2))
//        self.collectionView.scrollToItem(at:IndexPath(item: Int(center), section: 0), at: .centeredHorizontally, animated: false)
        
        
    }
    
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor(hue: 143/360, saturation: 95/100, brightness: 96/100, alpha: 1.0).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}
