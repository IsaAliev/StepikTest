//
//  CourseTableViewCell.swift
//  TestTask_Stepik
//
//  Created by user on 28.04.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit
import AFNetworking

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var courseTitleLabel : UILabel!
    @IBOutlet weak var courseSummaryLabel : UILabel!
    @IBOutlet weak var coverImageView : UIImageView!
    
    @IBOutlet weak var backView : UIView!
    
    var course : Course? {
        didSet {
            
            courseTitleLabel.text = course?.title
            courseSummaryLabel.text = course?.summary
            coverImageView.image = UIImage(named: "logo")
            if let urlString = course?.cover {
                
                let urlRequest = URLRequest(url: URL(string: "https://stepik.org"+urlString)!)
                coverImageView.setImageWith(urlRequest, placeholderImage: nil , success: { (requset, response, image) in
                    self.coverImageView.image = image as UIImage
                    }, failure: { (requset, response, error) in
                        print(error)
                })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView()
        view.backgroundColor = selectionColor()
        
        coverImageView.layer.cornerRadius = 10
        coverImageView.layer.masksToBounds = true

        self.selectedBackgroundView = view
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
