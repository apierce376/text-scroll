//
//  ContentView.swift
//  text scroll
//
//  Created by Aaron Pierce on 10/31/25.
//

import SwiftUI

struct ContentView: View {
    @State var start: String = "";
    @State var end: String = "";
    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    ScrollingText(old: 70, new: 100, animationDelay: 1)
                    Text("score")
                }
                HStack {
                    ScrollingText(old: 7.3, new: 9.4, step: 0.1, animationDelay: 2)
                    Text("hours")
                }
                HStack {
                    ScrollingText(old: 98, new: 83, animationDelay: 3)
                    Text("%")
                }
            }
        }
    }
    
    struct ScrollingText: View {
        private var viewHeight: CGFloat;
        private var old: String;
        private var new: String;
        private var values: Array<String> = [];
        private var animationDelay: Int;
        private var animationDuration: Double;
        
        public init (viewHeight: CGFloat = 50, old: Int = 0, new: Int = 10, step: Int = 1, animationDelay: Int = 1, animationDuration: Double = 4.0) {
            self.viewHeight = viewHeight;
            self.old = String(old);
            self.new = String(new);
            self.animationDelay = animationDelay;
            self.animationDuration = animationDuration;
            
            let lower = min(old, new)
            let higher = max(old, new)
            
            for i in stride(from: lower, through: higher, by: step).reversed() {
                values.append(String(i))
            }
        }
        
        public init (viewHeight: CGFloat = 50, old: Double = 0.0, new: Double = 10.0, step: Double = 0.1, animationDelay: Int = 1, animationDuration: Double = 4.0) {
            self.viewHeight = viewHeight;
            self.old = String(format: "%.1f", old);
            self.new = String(format: "%.1f", new);
            self.animationDelay = animationDelay;
            self.animationDuration = animationDuration;
            
            let lower = min(old, new)
            let higher = max(old, new)
            
            for i in stride(from: lower, through: higher, by: step).reversed() {
                values.append(String(format: "%.1f", i))
            }
        }
        
        var body: some View {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        ForEach(values, id: \.self) { index in
                            Text(index)
                                .id(index)
                                .frame(minHeight: viewHeight, maxHeight: viewHeight)
                                .font(Font.system(size: 35))
                                .fontWeight(Font.Weight.black)
                        }
                    }
                }
                .frame(height: viewHeight)
                .onAppear() {
                    proxy.scrollTo(old, anchor: .center)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(animationDelay), execute: {
                        withAnimation(.easeOut(duration: animationDuration)) {
                            proxy.scrollTo(new, anchor: .center)
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
