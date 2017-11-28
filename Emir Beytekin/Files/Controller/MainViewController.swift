//
//  MainViewController.swift
//  Emir Beytekin
//
//  Created by Emir Beytekin on 26.10.2017.
//  Copyright © 2017 Emir Beytekin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ViewAnimator
import Kingfisher
import MessageUI
import Foundation


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var cvUrl = "http://www.beytekin.net/emircv.php"
    struct Titles {
        var titName: String?
    }
    struct User {
        var id: Int?
        var name: String?
        var surname: String?
        var jobTitle: String?
        var avatar: String?
        var email: String?
        var aboutMe: String?
    }
    
    struct Education {
        var id: Int?
        var name: String?
        var startDate: String?
        var endDate: String?
    }
    struct Experience {
        var id: Int?
        var name: String?
        var position: String?
        var startDate: String?
        var endDate: String?
        var isActive: Bool?
    }
    struct Skills {
        var id: Int?
        var name: String?
        var values: Int?
    }
    struct Referrers {
        var name: String?
        var position: String?
        var phone: String?
        var phoneStr: String?
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loaderView: UIView!
    var userObjects :[User] = []
    var skillObjects :[Skills] = []
    var eduObjects :[Education] = []
    var expObjects: [Experience] = []
    var workObjects: [MyWorks] = []
    var refObjects: [Referrers] = []
    var titObjects: [Titles] = []
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .clear
        self.fetchData()
        makeTableView()
        NotificationCenter.default.addObserver(self,selector: #selector(self.pushInfo(_:)),name: NSNotification.Name(rawValue: "collectionClick"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self,selector: #selector(self.pushInfo(_:)),name: NSNotification.Name(rawValue: "collectionClick"), object: nil)
    }
    
    func pushInfo(_ notification: NSNotification) {
        
        guard let userInfo = notification.userInfo,
            let logo = userInfo["logo"] as? String,
            let link = userInfo["link"] as? String,
            let name = userInfo["name"] as? String,
            let description = userInfo["desc"] as? String
        
            else {
                return
        }
        
        let detailsVC: DetailViewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailsVC.appImage = logo
        detailsVC.appName = name
        detailsVC.appDescription = description
        detailsVC.appLink = link
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "collectionClick"),object: nil)
        let nc = UINavigationController(rootViewController: detailsVC)
        self.present(nc, animated: true, completion: nil)
//        navigationController?.pushViewController(nc, animated: true)
    }
    func makeTableView() {
        tableView.dataSource = self
        tableView.delegate = self
//        self.tableView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        tableView?.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableView?.register(UINib(nibName: "AboutMeTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutMeTableViewCell")
        tableView?.register(UINib(nibName: "MyWorksTableViewCell", bundle: nil), forCellReuseIdentifier: "MyWorksTableViewCell")
        tableView?.register(UINib(nibName: "SkillsTableViewCell", bundle: nil), forCellReuseIdentifier: "SkillsTableViewCell")
        tableView?.register(UINib(nibName: "ExperienceTableViewCell", bundle: nil), forCellReuseIdentifier: "ExperienceTableViewCell")
        tableView?.register(UINib(nibName: "EducationsTableViewCell", bundle: nil), forCellReuseIdentifier: "EducationsTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
//        view.animateRandom()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if(indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            if(userObjects.count > 0) {
                let c = userObjects[0]
                cell.userName.text = c.name!
                let url = URL(string: c.avatar!)
                cell.userAvatar.kf.setImage(with: url)
            }
            return cell
        } else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutMeTableViewCell", for: indexPath) as! AboutMeTableViewCell
            if(userObjects.count > 0) {
                cell.aboutLabel.text = userObjects[0].aboutMe
            }
            return cell
        } else if (indexPath.section == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyWorksTableViewCell", for: indexPath) as! MyWorksTableViewCell
            cell.wObjects = self.workObjects
            cell.collectionView.reloadData()
            return cell
        } else if (indexPath.section == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsTableViewCell", for: indexPath) as! SkillsTableViewCell
            if(skillObjects.count > 0) {
                let c = skillObjects[indexPath.row]
                cell.skillName.text = c.name
                cell.barConst.constant = (CGFloat(c.values! * 20))
                cell.skillVal.text = "\(String(describing: c.values!))/10"
            }
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableViewCell", for: indexPath) as! ExperienceTableViewCell
            if(expObjects.count > 0) {
                let c = expObjects[indexPath.row]
                cell.expName.text = c.name
                cell.expStart.text = c.startDate
                cell.expEnd.text = c.endDate
                cell.expPos.text = c.position
                if(c.isActive)! {
                    cell.expStatus.image = UIImage(named:"greenPoint")
                } else {
                    cell.expStatus.image = UIImage(named:"redPoint")
                }
                
            }
            return cell
        } else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EducationsTableViewCell", for: indexPath) as! EducationsTableViewCell
            if(eduObjects.count > 0) {
                let c = eduObjects[indexPath.row]
                cell.eduName.text = c.name
                cell.eduStart.text = c.startDate
                cell.eduEnd.text = c.endDate
            }
            return cell
        } else if indexPath.section == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableViewCell", for: indexPath) as! ExperienceTableViewCell
            
            if(refObjects.count > 0) {
                let c = refObjects[indexPath.row]
                cell.expName.text = c.name
                cell.expStart.text = ""
                cell.expEnd.text = ""
                cell.expPos.text = c.position
                cell.expStatus.image = UIImage(named:"greenPoint")
            }
            return cell
        } else if indexPath.section == 7 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "EducationsTableViewCell", for: indexPath) as! EducationsTableViewCell
            cell.eduName.text = "emir@beytekin.net"
            cell.eduStart.text = ""
            cell.eduEnd.text = ""
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 6 {
            let data = refObjects[indexPath.row]
            
            if let url = URL(string: "tel://\(data.phone ?? "")"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        if indexPath.section == 7 {
            self.sendEmail()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 34.0)
        cell.textLabel?.textColor = .white
        let backgroundView = UIView(frame: cell.bounds)
        backgroundView.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        cell.backgroundView = backgroundView
        
        if(self.titObjects.count > 0) {
            
            if section == 1  {
                cell.textLabel?.text = self.titObjects[0].titName
                return cell
            }
            if section == 2  {
                cell.textLabel?.text = self.titObjects[1].titName
                return cell
            }
            if section == 3 {
                cell.textLabel?.text = self.titObjects[2].titName
                return cell
            }
            if section == 4 {
                cell.textLabel?.text = self.titObjects[3].titName
                return cell
            }
            if section == 5 {
                cell.textLabel?.text = self.titObjects[4].titName
                return cell
            }
            if section == 6 {
                cell.textLabel?.text = self.titObjects[5].titName
                return cell
            }
            if section == 7 {
                cell.textLabel?.text = "İletişim"
            }
        }
        
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0 || section == 1 || section == 2) {
            return 1
        } else if section == 3 {
            return skillObjects.count 
        } else if section == 4 {
            return expObjects.count
        } else if section == 5 {
            return eduObjects.count
        } else if section == 6 {
            return refObjects.count
        } else if section == 7 {
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) { // header
            return 100
        } else if (indexPath.section == 1 ) { // ABOUT ME
            return UITableViewAutomaticDimension
        } else if (indexPath.section == 2) {
            return 120
        } else if indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 6 || indexPath.section == 7{
            return UITableViewAutomaticDimension
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0) {
            return 0
        }
        return 50
    }
    
    func fetchData() {
        
        self.showLoader()
        
        let urlString: String =  self.cvUrl
        
        Alamofire.request(urlString, method: .post, parameters:nil, encoding: URLEncoding.default , headers:nil).responseJSON { response in
            
            let x = response.response?.statusCode
            
            if (x == 500) {
                return
            }
            
            switch response.result {
            case .success(let value):
                
                let resp = JSON(value)
                let error: Bool = resp["error"].bool!
                if error == true {
                    print("hata var")
                } else {
                    
                    var user = User()
                    user.name = resp["data"]["name"].stringValue + " " + resp["data"]["surname"].stringValue
                    user.jobTitle = resp["data"]["jobTitle"].stringValue
                    user.aboutMe = resp["data"]["aboutMe"].stringValue
                    user.avatar = resp["data"]["userPic"].stringValue
                    self.userObjects.append(user)
                    
                    var skills = Skills()
                    for mySkl in resp["data"]["mySkills"].arrayValue {
                        skills.name = mySkl["name"].stringValue
                        skills.values = mySkl["value"].intValue
                        self.skillObjects.append(skills)
                    }
                    
                    for workz in resp["data"]["myWorks"].arrayValue {
                        let works = MyWorks()
                        works.name = workz["name"].stringValue
                        works.logo = workz["logo"].stringValue
                        works.link = workz["link"].stringValue
                        works.info = workz["info"].stringValue
                        self.workObjects.append(works)
                    }
                    
                    var educations = Education()
                    for edu in resp["data"]["myEducations"].arrayValue {
                        educations.name = edu["name"].stringValue
                        educations.startDate = edu["startDate"].stringValue
                        educations.endDate = edu["endDate"].stringValue
                        self.eduObjects.append(educations)
                    }
                    
                    var xps = Experience()
                    for exp in resp["data"]["myExp"].arrayValue {
                        xps.name = exp["name"].stringValue
                        xps.position = exp["position"].stringValue
                        xps.startDate = exp["startDate"].stringValue
                        xps.endDate = exp["endDate"].stringValue
                        xps.isActive = exp["isActive"].boolValue
                        self.expObjects.append(xps)
                    }
                    
                    var refs = Referrers()
                    for reff in resp["data"]["myRef"].arrayValue {
                        refs.name = reff["name"].stringValue
                        refs.phone = reff["phone"].stringValue
                        refs.phoneStr = reff["phoneStr"].stringValue
                        refs.position = reff["position"].stringValue
                        self.refObjects.append(refs)
                    }
                    
                    var titless = Titles()
                    for tits in resp["data"]["myTitles"].arrayValue {
                        titless.titName = tits["name"].stringValue
                        self.titObjects.append(titless)
                    }
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.tableView.reloadData()
                    })
                    self.hideLoader()
                    
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func showLoader() {
        self.loaderView.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(MainViewController.getRandomBackground), userInfo: nil, repeats: true)
        
    }
    
    func getRandomBackground() {
        UIView.animate(withDuration: 0.5, animations: {
            self.loaderView.layer.backgroundColor = self.getRandomColor().cgColor
        })
    }
    
    func hideLoader() {
        self.timer.invalidate()
        self.loaderView.isHidden = true
        self.loaderView.removeFromSuperview()
    }
    
    func getRandomColor() -> UIColor{
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["emir@beytekin.net"])
        composeVC.setSubject("iOS App")
        composeVC.setMessageBody("", isHTML: true)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}
