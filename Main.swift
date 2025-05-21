//
// Student.swift
//
// Created by Remy Skelton
// Created on 2025-May-20
// Version 1.0
// Copyright (c) Remy Skelton. All rights reserved.
//

import Foundation

// This class represents a student
public class Student {

    // Student's first name
    var firstName: String

    // Student's middle initial (can be empty)
    var midInit: String

    // Student's last name
    var lastName: String

    // Student's grade
    var grade: Int

    // Whether the student has an IEP
    var iep: Bool

    // Constructor with middle initial
    init(_ u_firstName: String, _ u_midInit: String, _ u_lastName: String,
         _ u_grade: Int, _ u_IEP: Bool) {
        self.firstName = u_firstName
        self.midInit = u_midInit
        self.lastName = u_lastName
        self.grade = u_grade
        self.iep = u_IEP
    }

    // Constructor without middle initial
    convenience init(_ u_firstName: String, _ u_lastName: String,
                     _ u_grade: Int, _ u_IEP: Bool) {
        self.init(u_firstName, "", u_lastName, u_grade, u_IEP)
    }

    // Method to return a string with the student's information
    func printStudent() -> String {
        var fullName: String

        // Build full name with or without middle initial
        if midInit.isEmpty {
            fullName = "\(firstName) \(lastName)"
        } else {
            fullName = "\(firstName) \(midInit). \(lastName)"
        }

        // Add IEP information
        let iepStr = iep ? "has an IEP." : "does not have an IEP."

        /*
         * Combine the full name, grade, and IEP status into a descriptive string.
         */
        return "\(fullName) is in grade \(grade) and \(iepStr)"
    }
}

// Main program starts here

do {
    // File paths
    let inputFile = "input.txt"
    let outputFile = "output.txt"

    // Read input file contents
    let inputContents = try String(contentsOfFile: inputFile, encoding: .utf8)

    // Split the input into lines
    let lines = inputContents.components(separatedBy: .newlines)

    // List to hold all students
    var listOfStudents = [Student]()

    // Process each line in the input file
    for line in lines {
        // Skip empty or whitespace-only lines
        if line.trimmingCharacters(in: .whitespaces).isEmpty {
            continue
        }

        // Split the line into parts using spaces
        let parts = line.split(separator: " ").map { String($0) }

        // Check parts length to parse appropriately
        if parts.count == 5 {
            // First name, middle initial, last name, grade, IEP
            let firstName = parts[0]
            let midInit = parts[1]
            let lastName = parts[2]
            guard let grade = Int(parts[3]) else { continue }
            let iep = parts[4].lowercased() == "y"

            // Create student with middle initial and add to list
            let student = Student(firstName, midInit, lastName, grade, iep)
            listOfStudents.append(student)

        } else if parts.count < 4 {
            // Ignore empty or invalid lines
            continue

        } else {
            // First name, last name, grade, IEP (no middle initial)
            let firstName = parts[0]
            let lastName = parts[1]
            guard let grade = Int(parts[2]) else { continue }
            let iep = parts[3].lowercased() == "y"

            // Create student without middle initial and add to list
            let student = Student(firstName, lastName, grade, iep)
            listOfStudents.append(student)
        }
    }

    // Prepare output string
    var output = ""
    output += "There are \(listOfStudents.count) students in the student list.\n"
    output += "The students are:\n\n"

    // Add student info lines
    for student in listOfStudents {
        output += student.printStudent() + "\n"
    }

    // Write to output file
    try output.write(toFile: outputFile, atomically: true, encoding: .utf8)

    print("Student list written to output.txt.")

} catch {
    print("Error: \(error)")
}
