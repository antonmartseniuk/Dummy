//
//  DetailView.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 01.10.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import SwiftUI
import Combine
import struct Kingfisher.KFImage

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    // TODO: Should be refactored and divide views into several child views
    var body: some View {
        userProfile(viewModel.userProfile)
            .eraseToAnyView()
            .onAppear {
                self.viewModel.getUserDetails()
        }
    }
}

private func userProfile(_ user: UserProfile) -> some View {
    VStack(alignment: .center) {
        KFImage(URL(string: user.pictureURL))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 120)
            .clipped()
            .cornerRadius(60)
            .padding(10)
        Text(user.fullName)
            .font(.subheadline)
        HStack(alignment: .center, spacing: 10) {
            Text(user.email)
                .padding(.all, 10)
                .lineSpacing(10)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            Divider()
                .frame(height: 30)
            Text(user.phone)
                .padding(.all, 10)
                .lineSpacing(10)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
        }
        .font(.system(size: 13))
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: 30,
               alignment: .center)
        Text(user.fullLocation)
            .font(.body)
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                print("HELLo")
            }) {
                VStack {
                    Image(systemName: "message")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text("152")
                        .foregroundColor(.gray)
                }
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: 70,
                   alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.blue, lineWidth: 1))
            Button(action: {
                print("HELLo")
            }) {
                VStack {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text("333")
                        .foregroundColor(.gray)
                }
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: 70,
                   alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.blue, lineWidth: 1))
            Button(action: {
                print("HELLo")
            }) {
                VStack {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text("901")
                        .foregroundColor(.gray)
                }
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: 70,
                   alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.blue, lineWidth: 1))
            Button(action: {
                print("HELLo")
            }) {
                VStack {
                    Image(systemName: "pencil.and.outline")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text("33")
                        .foregroundColor(.gray)
                }
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: 70,
                   alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.blue, lineWidth: 1))
        }
        
        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry")
            .padding(.all, 10)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: 90,
                   alignment: .center
        )
            .layoutPriority(1)
        HStack(spacing: 0) {
            Button(action: {
                print("TAPPED")
            }) {
                VStack {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text("Follow")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               minHeight: 0,
                               maxHeight: 70,
                               alignment: .center
                    )
                }
                .overlay(RoundedRectangle(cornerRadius: 0)
                .stroke(Color.blue, lineWidth: 1))
            }
            Button(action: {
                print("TAPPED")
            }) {
                VStack {
                    Image(systemName: "paperplane")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text("Message")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               minHeight: 0,
                               maxHeight: 70,
                               alignment: .center
                    )
                }
                .overlay(RoundedRectangle(cornerRadius: 0)
                .stroke(Color.blue, lineWidth: 1))
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: 50,
               alignment: .center
        )
        
        VStack {
            Text("Markets")
                .font(.headline)
                .padding(.all, 5)
            Text("Qatar exchanged • Something Another")
                .lineSpacing(10)
                .padding([.leading, .trailing,], 40)
                .multilineTextAlignment(.center)
            
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: 120,
               alignment: .center
        )
            .overlay(RoundedRectangle(cornerRadius: 0)
                .stroke(Color.blue, lineWidth: 1))
        
        VStack {
            Text("Qualification")
                .font(.headline)
                .padding(.all, 10)
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       alignment: .center
            )
            Text("One • Two • Three")
        }
        Spacer()
    }
}
