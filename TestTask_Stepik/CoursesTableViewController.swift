//
//  CoursesTableViewController.swift
//  TestTask_Stepik
//
//  Created by user on 28.04.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class CoursesTableViewController: UITableViewController {


    var courses = [Course]()
    var currentPage = 0
    var hasNext = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {

        if hasNext {

            let refresh = (refreshControl?.isRefreshing)!
            currentPage =  currentPage + 1
            ServerManager.shared.getCoursesList(onPage: currentPage, onSucces: { (courses, hasNext) in
                self.hasNext = hasNext

                var indices = [IndexPath]()
                
                let firstIndex = self.currentPage == 1 ? 0 : self.courses.count
                
                for i in firstIndex..<(courses?.count)!+firstIndex {
                    indices.append(IndexPath(row: i, section: 0))
                }
                
                if refresh {
                    self.courses.removeAll()
                    self.courses.append(contentsOf: courses!)
                }else {
                    self.courses.append(contentsOf: courses!)
                }
                
                DispatchQueue.main.async {
                    if !refresh {
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: indices, with: .top)
                        self.tableView.endUpdates()
                    }else {
                        self.tableView.reloadData()
                    }
                    self.refreshControl?.endRefreshing()
                }
                
            }) { (error) in
                let ac = UIAlertController(title: "Ошибка", message: "Не удалось загрузить данные \n \(error.localizedDescription)", preferredStyle: .alert)

                ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hasNext ? courses.count+1 : courses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < courses.count {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseTableViewCell
            cell.course = courses[indexPath.row]
            
            if indexPath.row == courses.count - 2 {
                getData()
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) 
            return cell
        }
        

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == courses.count ? 60 : 150
    }

    //MARK: - Actions
    
    @IBAction func refreshControlAction(_ sender: UIRefreshControl) {

        if sender.isRefreshing {
            currentPage = 0
            getData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! CourseInfoTableViewController).course =  (sender as! CourseTableViewCell).course
        
    }
    

}
