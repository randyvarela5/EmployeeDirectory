//
//  EmployeeCell.swift
//  Employee Directory
//
//  Created by Randy Varela on 2/19/22.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var employeeTeam: UILabel!
    
    func setEmployee(employee: Employee) {
//        employeeImage.image = employee.image
//        employeeName.text = employee.name
//        employeeTeam.text = employee.team
    }
}
