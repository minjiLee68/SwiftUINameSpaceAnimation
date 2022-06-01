//
//  ContentView.swift
//  SwiftUI_TabBar_Animation
//
//  Created by 이민지 on 2022/06/01.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentTab: Int = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $currentTab) {
                View1().tag(0)
                View2().tag(1)
                View3().tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)
            
            TabBarView(currentTab: self.$currentTab)
            
        }
    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var nameSpace
    var tabBarViewOptions: [String] = ["minjiView1", "minjiView2", "minjiView3"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Array(zip(self.tabBarViewOptions.indices, self.tabBarViewOptions)), id: \.0) { index, name in
                    TabBarItem(currentTab: self.$currentTab,
                               nameSpace: nameSpace.self,
                               tabBarItemName: name,
                               tab: index)
                }
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .frame(height: 80)
        .edgesIgnoringSafeArea(.all)
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let nameSpace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button{
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                if currentTab == tab {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(
                            id: "underline",
                            in: nameSpace,
                            properties: .frame)
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
        .buttonStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
