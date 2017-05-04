//
//  InstructorsTableViewCell.swift
//  TestTask_Stepik
//
//  Created by user on 01.05.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class InstructorsTableViewCell: UITableViewCell, UICollectionViewDataSource {

    @IBOutlet weak var collectionView : UICollectionView!

    var course : Course!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        let view = UIView()
        view.backgroundColor = selectionColor()
        
        self.selectedBackgroundView = view
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (course.instructors?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InstructorCollectionViewCell

        cell.avatarImageView.layer.cornerRadius = 30
        cell.avatarImageView.layer.masksToBounds = true
        cell.avatarImageView.layer.borderColor = mainColor().withAlphaComponent(0.5).cgColor
        cell.avatarImageView.layer.borderWidth = 2
        
        if let instructor = course.detailedInstructors?[indexPath.row] {
      
            cell.nameLabel.text = instructor.firstName! + " " +  instructor.lastName!
            if let avatar = instructor.avatar {
                let request = URLRequest(url: URL(string: avatar)!)
                cell.avatarImageView.setImageWith(request, placeholderImage: nil, success: { (request, response, image) in
                    
            cell.avatarImageView.image = image 
                    
                    }, failure: {(error) in
                
                        cell.avatarImageView.setImageForName(string: instructor.firstName!+" "+instructor.lastName!, backgroundColor: mainColor().withAlphaComponent(0.2), circular: true, textAttributes: [NSForegroundColorAttributeName : UIColor.black,NSFontAttributeName :  cell.nameLabel.font.withSize(21)])
                })
            } else {
                cell.avatarImageView.setImageForName(string: instructor.firstName!+" "+instructor.lastName!, backgroundColor: mainColor().withAlphaComponent(0.2), circular: true, textAttributes: [NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 20)])
            }
            
        }
        
        return cell
    }

}
