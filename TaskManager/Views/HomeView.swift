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
    }
    
    // MARK: Tasks View
    func TasksView() -> some View {
        LazyVStack {
            
        }
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
        .background(Color.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
