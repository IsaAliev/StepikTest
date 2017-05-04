//
//  CourseInfoTableViewController.swift
//  TestTask_Stepik
//
//  Created by user on 01.05.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class CourseInfoTableViewController: UITableViewController {

    var handler : CourseInfoTableHandler!
    var course : Course!
    var lastSelectedIndexOfSegmentrdControl = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerManager.shared.getUsersInfo(fromIDs: course.instructors!, onSucces: { [weak self] (users) in
            self?.course.detailedInstructors = users

            if self?.lastSelectedIndexOfSegmentrdControl == 0 {
                self?.tableView.beginUpdates()
                self?.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
                self?.tableView.endUpdates()
            }
            
            }) { (error) in
                print("ERROR IN LOADING INSTRUCTORS INFO \(error)")
        }
        
        ServerManager.shared.getSectionsInfo(fromIDs: course.sections!, onSucces: { [weak self] (sections) in
            self?.course.detailedSections = sections

            if self?.lastSelectedIndexOfSegmentrdControl == 2 {
                var indices = [IndexPath]()
                
                for i in 0..<sections.count{
                    indices.append(IndexPath(row: i, section: 0))
                }
                
                self?.tableView.beginUpdates()
                self?.tableView.reloadRows(at: indices, with: .fade)
                self?.tableView.endUpdates()
            }
            
        }) { (error) in
            print("ERROR IN LOADING SECTIONS INFO \(error)")
        }

        self.navigationItem.title = "Курс"
        
        handler = CourseInfoTableHandler(course: course)
        self.tableView.dataSource = handler
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        setupHeader()
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Appearance
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        let vsc = newCollection.verticalSizeClass.rawValue
        
        if vsc == 2 {
            let ratio = 211.0/375.0 as CGFloat
            let w = UIScreen.main.bounds.height
            let h = ratio*w
            
            let rect = CGRect(x: 0, y: 0, width: w, height: h)
            
            self.tableView.tableHeaderView?.frame = rect
        }
    }
    
    func setupHeader() {
        if let thumb =  course.intro?.thumbnail {
            let ratio = 211.0/375.0 as CGFloat
            let w = UIScreen.main.bounds.width
            let h = ratio*w
            let rect = CGRect(x: 0, y: 0, width: w, height: h)
            let hview = UIView(frame: rect)
            
            let imageView = UIImageView(frame: rect)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            let playImage = UIImage(named: "playButton")
            let playButton = UIButton(type: .custom)
            playButton.setImage(playImage, for: .normal)
            playButton.addTarget(self, action: #selector(CourseInfoTableViewController.playVideoButtonAction(sender:)), for: .touchUpInside)
            
            
            imageView.setImageWith(URLRequest(url: thumb), placeholderImage: UIImage(color: mainColor().withAlphaComponent(0.3)), success: { (request, response, image) in
                
                imageView.image = image
                }, failure: nil)
            
            hview.addSubview(imageView)
            hview.addSubview(playButton)
            
            playButton.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: hview, attribute: .top, multiplier: 1.0, constant: 0),
                                         NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: hview, attribute: .bottom, multiplier: 1.0, constant: 0),
                                         NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: hview, attribute: .right, multiplier: 1.0, constant: 0),
                                         NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: hview, attribute: .left, multiplier: 1.0, constant: 0),
                                         NSLayoutConstraint(item: playButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60),
                                         NSLayoutConstraint(item: playButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60),
                                         NSLayoutConstraint(item: playButton, attribute: .centerX, relatedBy: .equal, toItem: hview, attribute: .centerX, multiplier: 1.0, constant: 0),
                                         NSLayoutConstraint(item: playButton, attribute: .centerY, relatedBy: .equal, toItem: hview, attribute: .centerY, multiplier: 1.0, constant: 0)])
            
            
            self.tableView.tableHeaderView = hview
        }
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableCell(withIdentifier: "header") as! HeaderTableViewCell
        view.courseNameLabel.text = course.title
        view.segControl.addTarget(self, action: #selector(CourseInfoTableViewController.contentChanged(sender:)), for: .valueChanged)
        view.contentView.backgroundColor = UIColor.white
        return view.contentView
    }   
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Actions
    
    func playVideoButtonAction(sender: UIButton)  {
        if let urls = course.intro?.urls  {
            let url = URL(string: urls.first?["url"] as! String)
            let player = AVPlayer(url: url!)
            let av = AVPlayerViewController()
            av.player = player
            av.view.frame = (self.tableView.tableHeaderView?.frame)!
            self.addChildViewController(av)
            self.tableView.tableHeaderView?.addSubview(av.view)
            av.didMove(toParentViewController: self)
        }
    }
    
    func contentChanged(sender: UISegmentedControl)  {
        
        let oldConfig = handler.currentConfigurationObject!
        
        switch sender.selectedSegmentIndex {
        case 0:
            handler.configuration = .common
            tableView.separatorStyle = .none
        case 1:
             handler.configuration = .detailed
             tableView.separatorStyle = .none
        case 2:
            handler.configuration = .sections
            tableView.separatorStyle = .none
        default:
            break
        }
        
        var idxToDelete = [IndexPath]()
        var idxToInsert = [IndexPath]()
        
        for i in 0..<handler.currentConfigurationObject.rows {
            idxToInsert.append(IndexPath(row: i, section: 0))
        }
        
        for i in 0..<oldConfig.rows {
            idxToDelete.append(IndexPath(row: i, section: 0))
        }
        
        let insertAnimation : UITableViewRowAnimation = lastSelectedIndexOfSegmentrdControl < sender.selectedSegmentIndex ? .right : .left
        let deleteAnimation : UITableViewRowAnimation = lastSelectedIndexOfSegmentrdControl < sender.selectedSegmentIndex ? .left : .right
        
        
        tableView.beginUpdates()
        tableView.deleteRows(at: idxToDelete, with: deleteAnimation)
        tableView.insertRows(at: idxToInsert, with: insertAnimation)
        tableView.endUpdates()
        
        lastSelectedIndexOfSegmentrdControl = sender.selectedSegmentIndex
    }


}
