//
//  SelectedCoursesCell.swift
//  SelectedCoursesCell
//
//  Created by Shubham Behal on 04/11/21.
//

import Foundation
import UIKit
class SelectedCoursesCell: UITableViewCell {
    
    @IBOutlet weak var lblCourseName: UILabel!
    var controller : ViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCourseCell(course: String, controller : ViewController)
    {
        lblCourseName.text = course
        self.controller = controller
    }

    @IBAction func onCourseRemoved(_ sender: Any) {
        controller.onCourseRemoved(course: lblCourseName.text!)
    }
}
