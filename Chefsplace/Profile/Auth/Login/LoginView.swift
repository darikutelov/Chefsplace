//
//  LoginView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct LoginView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
            VStack {
                DismissButton(isPresented: $isPresented)
                Text(String(localized: "signin_label"))
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
                VStack {
                    Text("Sign In")
                        .foregroundColor(.white)
                    HStack {
                        Spacer()
                    }
                }
                .frame(minHeight: 300)
                .background {
                    Rectangle()
                        .fill(
                            Color(Constants.Colors.primary)
                        )
                        .cornerRadius(Constants.Spacing.standardPlus)
                        .padding(.bottom, -Constants.Spacing.xlarge)
                        .ignoresSafeArea(.all)
                }
            }
            .background(
                Image(Constants.Images.loginBg)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
            )
        }
}

struct DismissButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                isPresented = false
            } label: {
                Image(systemName: "xmark.circle")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.trailing, 24)
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isPresented: .constant(true))
    }
}
