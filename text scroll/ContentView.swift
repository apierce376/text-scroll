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
                    ScrollingText(old: 70, new: 105, animationDelay: 1);
                    Text("%")
                }
                HStack {
                    ScrollingText(old: 80, new: 92, animationDelay: 2);
                    Text("hours")
                }
                HStack {
                    ScrollingText(old: 97, new: 87, animationDelay: 3);
                    Text("%")
                }
            }
        }
    }
    
    struct ScrollingText: View {
        private var viewHeight: CGFloat;
        private var old: Int;
        private var new: Int;
        private var animationDelay: Int;
        private var animationDuration: Double;
        
        public init (viewHeight: CGFloat = 50, old: Int = 0, new: Int = 10, animationDelay: Int = 1, animationDuration: Double = 4.0) {
            self.viewHeight = viewHeight;
            self.old = old;
            self.new = new;
            self.animationDelay = animationDelay;
            self.animationDuration = animationDuration;
        }
        
        
        var body: some View {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        let lower = old > new ? new : old;
                        let higher = old > new ? old : new;
                        
                        ForEach(lower...higher, id: \.self) { index in
                            Text("\(index)")
                                .id(index)
                                .frame(width: .infinity, height: viewHeight)
                                .font(Font.system(size:35))
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
