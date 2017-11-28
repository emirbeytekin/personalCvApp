//
//  DetailViewController.swift
//  Emir Beytekin
//
//  Created by Emir Beytekin on 2.11.2017.
//  Copyright © 2017 Emir Beytekin. All rights reserved.
//

import UIKit
import ParallaxHeader
import Kingfisher

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
     weak var headerImageView: UIView?
    var appImage = ""
    var appName = ""
    var appDescription = ""
    var appLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupParallaxHeader()
        self.title = appName
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.isOpaque = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont.boldSystemFont(ofSize: 22.0), NSForegroundColorAttributeName: UIColor.black]
        
        let dismissButton:UIButton = UIButton(type: .custom)
        dismissButton.frame = CGRect(x: 0, y: 0, width: 60, height: 12)
        dismissButton.imageView?.contentMode = .scaleAspectFit
        dismissButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 45)
        dismissButton.setImage(UIImage(named: "cancel_black_icon"), for: .normal)
        dismissButton.tintColor = UIColor.yellow
        dismissButton.addTarget(self, action: #selector(self.popToRoot), for: .touchUpInside)
        let dismissButtonItem:UIBarButtonItem = UIBarButtonItem(customView: dismissButton)
        self.navigationItem.leftBarButtonItem = dismissButtonItem
        
        tableView.tableFooterView = UIView()
        
        tableView?.register(UINib(nibName: "DownloadTableViewCell", bundle: nil), forCellReuseIdentifier: "DownloadTableViewCell")

    }
    
    func popToRoot() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupParallaxHeader() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        let url1 = URL(string: self.appImage)
        imageView.kf.setImage(with: url1)
        headerImageView = imageView
        tableView.parallaxHeader.view = imageView
        tableView.parallaxHeader.height = 320
        tableView.parallaxHeader.minimumHeight = 0
        tableView.parallaxHeader.mode = .centerFill
        tableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
//            print(parallaxHeader.progress)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            cell.textLabel?.text = appDescription
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.textColor = .black
            return cell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func downloadAppAct(_ sender: Any) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/\(self.appLink)"),
            UIApplication.shared.canOpenURL(url)
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

}
