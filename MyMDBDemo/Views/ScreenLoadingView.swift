//
//  ScreenLoadingView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI

struct ScreenLoadingView: View {
    
    let download: Bool
    let error: NSError?
    let redoAction: (() -> ())?
    
    var body: some View {
        Group {
            if download {
                HStack {
                    Spacer()
                    ActivityIndicatorScreenView()
                    Spacer()
                }
            } else if error != nil {
                HStack {
                    Spacer()
                    VStack(spacing: 6) {
                        Text(error!.localizedDescription).font(.headline)
                        if self.redoAction != nil {
                            Button(action: self.redoAction!) {
                                Text("Redo")
                            }
                            .foregroundColor(Color(UIColor.systemBlue))
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ScreenLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenLoadingView(download: true, error: nil, redoAction: nil)
    }
}
