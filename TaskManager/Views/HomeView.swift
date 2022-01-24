//
//  HomeView.swift
//  TaskManager
//
//  Created by Stanley Pan on 2022/01/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // MARK: Lazy Stack with Pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    // MARK: Current Week View
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            
                        }
                    }
                } header: {
                    HeaderView()
                }
            }
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
