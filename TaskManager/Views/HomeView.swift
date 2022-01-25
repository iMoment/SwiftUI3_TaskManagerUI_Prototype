//
//  HomeView.swift
//  TaskManager
//
//  Created by Stanley Pan on 2022/01/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var taskVM: TaskViewModel = TaskViewModel()
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // MARK: Lazy Stack with Pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                
                Section {
                    // MARK: Current Week View
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 10) {
//                            Spacer()
                            
                            ForEach(taskVM.currentWeek, id: \.self) { day in
                                
                                VStack(spacing: 10) {
                                    Text(taskVM.getDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    
                                    Text(taskVM.getDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                    
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(taskVM.isToday(date: day) ? 1 : 0)
                                }
                                .foregroundStyle(taskVM.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(taskVM.isToday(date: day) ? Color.white : Color.black)
                                // MARK: Capsule Shape
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack {
                                        // MARK: Matched Geometry Effect
                                        if taskVM.isToday(date: day) {
                                            Capsule()
                                                .fill(Color.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation {
                                        taskVM.currentDay = day
                                    }
                                }
                            }
                            
//                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    TasksView()
                    
                } header: {
                    HeaderView()
                }
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    // MARK: Tasks View
    func TasksView() -> some View {
        LazyVStack(spacing: 20) {
            if let tasks = taskVM.filteredTasks {
                if tasks.isEmpty {
                    Text("No tasks found!")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                } else {
                    ForEach(tasks) { task in
                        TaskCardView(task: task)
                    }
                }
            } else {
                // MARK: Progress View
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        
        // MARK: Updating Tasks
        .onChange(of: taskVM.currentDay) { newValue in
            taskVM.filterTodayTasks()
        }
    }
    
    // MARK: Task Card View
    func TaskCardView(task: Task) -> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack(spacing: 10) {
                Circle()
                    .fill(taskVM.isCurrentHour(date: task.taskDate) ? Color.black : Color.clear)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(Color.black, lineWidth: 1)
                            .padding(-3)
                    )
                    .scaleEffect(!taskVM.isCurrentHour(date: task.taskDate) ? 0.8 : 1)
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 3)
            }
            
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(task.taskTitle)
                            .font(.title2.bold())
                        
                        Text(task.taskDescription)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .hLeading()
                    
                    Text(task.taskDate.formatted(date: .omitted, time: .shortened))
                }
                
                if taskVM.isCurrentHour(date: task.taskDate) {
                    // MARK: Team Members
                    HStack(spacing: 0) {
                        HStack(spacing: -10) {
                            ForEach(["profile2", "profile3", "profile4"], id: \.self) { member in
                                Image(member)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    .background(
                                        Circle()
                                            .stroke(Color.black, lineWidth: 5)
                                    )
                            }
                        }
                        .hLeading()
                        
                        // MARK: Check Button
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(Color.black)
                                .padding(10)
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(.top)
                }
            }
            .foregroundColor(taskVM.isCurrentHour(date: task.taskDate) ? Color.white : Color.black)
            .padding(taskVM.isCurrentHour(date: task.taskDate) ? 15 : 0)
            .padding(taskVM.isCurrentHour(date: task.taskDate) ? 0 : 10)
            .hLeading()
            .background(
                Color("selectBlack")
                    .cornerRadius(25)
                    .opacity(taskVM.isCurrentHour(date: task.taskDate) ? 1 : 0)
            )
        }
        .hLeading()
    }
    
    // MARK: Header View
    func HeaderView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(Color.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button {
                
            } label: {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(Color.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
