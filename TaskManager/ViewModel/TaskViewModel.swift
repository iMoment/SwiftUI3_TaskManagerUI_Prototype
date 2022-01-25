//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Stanley Pan on 2022/01/24.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var storedTasks: [Task] = [
        Task(taskTitle: "Meeting", taskDescription: "Discuss team task for the day.", taskDate: .init(timeInterval: (86400 * 1), since: Date())),
        Task(taskTitle: "Icon Set", taskDescription: "Edit icons for team task for next week.", taskDate: .init(timeInterval: (86400 * 2), since: Date())),
        Task(taskTitle: "Prototype", taskDescription: "Make and send prototype.", taskDate: .init(timeInterval: (86400 * 3), since: Date())),
        Task(taskTitle: "Check Assets", taskDescription: "Start checking the assets.", taskDate: .init(timeInterval: (86400 * 4), since: Date())),
        Task(taskTitle: "Team Party", taskDescription: "Attend the party with team members.", taskDate: .init(timeInterval: (86400 * 5), since: Date())),
        Task(taskTitle: "Client Meeting", taskDescription: "Explain project to client.", taskDate: .init(timeInterval: (86400 * 6), since: Date())),
        Task(taskTitle: "Next Project", taskDescription: "Discuss next project with team.", taskDate: .init(timeInterval: (86400 * 7), since: Date())),
        Task(taskTitle: "App Proposal", taskDescription: "Meet client for next App Proposal.", taskDate: .init(timeInterval: (86400 * 1), since: Date())),
        Task(taskTitle: "Production Build", taskDescription: "Testing of prod build", taskDate: .init(timeInterval: (86400 * 2), since: Date()))
    ]
    
    // MARK: Fetch current week dates
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    
    init() {
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    // MARK: Filtering Today's Tasks
    @Published var filteredTasks: [Task]?
    
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            let filtered = self.storedTasks.filter {
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else { return }
        
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    // MARK: Extracting Formatted Date String
    func getDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    // MARK: Checking current date
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
