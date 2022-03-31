//
//  Employee.swift
//  Employee Directory
//
//  Created by Randy Varela on 2/19/22.
//

import Foundation

// MARK: - Employee
struct Employee: Codable {
    let employees: [EmployeeElement]
}

// MARK: - EmployeeElement
struct EmployeeElement: Codable {
    let uuid, fullName, phoneNumber, emailAddress: String
    let biography: String
    let photoURLSmall, photoURLLarge: String
    let team: String
    let employeeType: EmployeeType

    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}

enum EmployeeType: String, Codable {
    case contractor = "CONTRACTOR"
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
}
