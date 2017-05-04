//
//  Course.swift
//  TestTask_Stepik
//
//  Created by user on 28.04.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import Foundation

class Course : NSObject {
    
    struct Intro {
        var thumbnail : URL?
        var urls : [NSDictionary]?
    }
    
    
    var courseDescription : String?
    var summary : String?
    var slug : String?
    var courseFormat : String?
    var requirements : String?
    var targetAudience : String?
    var workload : String?
    var cover : String?
    var certificate : String?
    var teachersGroup : [String]?
    var title : String?
    var instructors : [NSNumber]?
    var authors : [NSNumber]?
    var intro : Intro?
    var introVideoURL : URL?
    var sections : [NSNumber]?
    
    
    var detailedInstructors : [User]?
    var detailedSections : [Section]?
    
    init(withResponse response: NSDictionary) {

        if let summary = response["summary"] as? String {
            self.summary = normalizeString(string: summary)
        }
        
        self.slug = response["slug"] as? String
        self.courseFormat = response["course_format"] as? String

        if let courseDescription = response["description"] as? String {
            self.courseDescription = normalizeString(string: courseDescription)
        }
        if let requirements = response["requirements"] as? String {
            self.requirements = normalizeString(string: requirements)
        }

        self.targetAudience = response["target_audience"] as? String
        self.workload = response["workload"] as? String
        self.cover = response["cover"] as? String
        self.certificate = response["certificate"] as? String
        self.teachersGroup = response["teachers_group"] as? [String]
        self.title = response["title"] as? String
        self.instructors = response["instructors"] as? [NSNumber]
        self.authors = response["authors"] as? [NSNumber]
        self.sections = response["sections"] as? [NSNumber]
        if let intro =  response["intro"] as? String {
            if !intro.isEmpty {
                self.introVideoURL = URL(string: intro)
            }
        }
        
        if let introResponse =  response["intro_video"] as? NSDictionary {
            if let thumb = (introResponse["thumbnail"]) as? String {
                self.intro = Intro(thumbnail: URL(string:thumb), urls: (introResponse["urls"]) as? [NSDictionary] )
            }
        }
        
        
    }
    

}
