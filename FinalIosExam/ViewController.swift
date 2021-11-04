//
//  ViewController.swift
//  FinalIosExam
//
//  Created by Shubham Behal on 04/11/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    let courses = ["Java","Python","Database","Web development","iOS development","Android development","System analysis","Cloud computing","Machine learning","Problem-solving"]
    var courseList = [Course]()
    var selectedCourses: [String] = []
    var totalHours = 0
    var totalFees = 0
    
    
    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblFees: UILabel!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblTotalHours: UILabel!
    @IBOutlet weak var lblTotalFees: UILabel!
    @IBOutlet weak var lblTotalHoursValue: UILabel!
    @IBOutlet weak var lblTotalFeesValue: UILabel!
    @IBOutlet weak var selectedCoursesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        coursePicker.dataSource = self
        coursePicker.delegate = self
        selectedCoursesTable.dataSource = self
        selectedCoursesTable.delegate = self
        fillData()
        lblHours.text = String(courseList[0].hours)
        lblFees.text = String(courseList[0].fee)
    }
    
    func fillData(){
        courseList.append(Course(name: courses[0], hours: 5, fee: 1600))
        courseList.append(Course(name: courses[1], hours: 4, fee: 1850))
        courseList.append(Course(name: courses[2], hours: 3, fee: 1300))
        courseList.append(Course(name: courses[3], hours: 4, fee: 1200))
        courseList.append(Course(name: courses[4], hours: 5, fee: 2200))
        courseList.append(Course(name: courses[5], hours: 5, fee: 2000))
        courseList.append(Course(name: courses[6], hours: 4, fee: 1900))
        courseList.append(Course(name: courses[7], hours: 3, fee: 1250))
        courseList.append(Course(name: courses[8], hours: 5, fee: 2300))
        courseList.append(Course(name: courses[9], hours: 3, fee: 950))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return courses[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblHours.text = String(courseList[row].hours)
        lblFees.text = String(courseList[row].fee)
        lblError.isHidden = true
    }
    
    @IBAction func onCourseSelected(_ sender: Any) {
        let selectedCourse = courseList[coursePicker.selectedRow(inComponent: 0)]
        if(selectedCourses.contains(selectedCourse.name)){
            lblError.isHidden = false
            lblError.text = "Oops!!! The selected course already exists in the list!!!"
        }
        else if((totalHours + selectedCourse.hours) > 19 ){
            lblError.isHidden = false
            lblError.text = "Oops!!! The selected hours cannot exceed 19 hours!!!"
        }else{
            selectedCourses.append(selectedCourse.name)
            totalHours = totalHours + selectedCourse.hours
            totalFees = totalFees + selectedCourse.fee
            selectedCoursesTable.reloadData()
            showHideFinalDetails()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let course = selectedCourses[indexPath.row]
        let cell = selectedCoursesTable.dequeueReusableCell(withIdentifier: "courses") as? SelectedCoursesCell
        cell?.setCourseCell(course: course, controller : self)
        return cell!
    }
    
    func onCourseRemoved(course: String){
        if let index = selectedCourses.firstIndex(of: course) {
            selectedCourses.remove(at: index)
        }
        for c in courseList{
            if c.name == course{
                totalHours = totalHours - c.hours
                totalFees = totalFees - c.fee
            }
        }
        selectedCoursesTable.reloadData()
        showHideFinalDetails()
    }
    
    func showHideFinalDetails(){
        if(totalHours == 0){
            lblTotalFees.isHidden = true
            lblTotalHours.isHidden = true
            lblTotalFeesValue.isHidden = true
            lblTotalHoursValue.isHidden = true
        }else{
            lblTotalFees.isHidden = false
            lblTotalHours.isHidden = false
            lblTotalFeesValue.isHidden = false
            lblTotalHoursValue.isHidden = false
            lblTotalFeesValue.text = String(totalFees)
            lblTotalHoursValue.text = String(totalHours)
        }
    }
}

