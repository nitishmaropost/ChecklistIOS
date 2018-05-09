//
//  ChecklistViewModel.swift
//  Checklist
//
//  Created by Nitish on 20/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import Foundation

class ChecklistViewModel {
    
    var checklistItems: [ChecklistItemViewModel] = [ChecklistItemViewModel]()
    
    class ChecklistItemViewModel {
        var name: String!
        var deadline: String!
        var logo: String!
        
        init(name: String, deadline: String, logo: String) {
            self.name = name
            self.deadline = deadline
            self.logo = logo
        }
        
        init(checklist: Checklist) {
            self.name = checklist.name
            self.deadline = checklist.deadline
            switch checklist.tag {
            case 0:
                self.logo = "grocery.png"
            case 1:
                self.logo = "travel.png"
            case 2:
                self.logo = "movie.png"
            case 3:
                self.logo = "work.png"
            default:
                self.logo = ""
            }
        }
    }
}
