//
//  NormalPostView.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/16/20.
//

import SwiftUI

struct NormalPostView: View {
    var body: some View {
        VStack(alignment: .leading) {
            PostHeadView()
            MainBody()
                .foregroundColor(Color.gray99)
                .padding(.bottom, 15)
                .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Color.gray39
                .frame(height: 1, alignment: .center)
            ButtonHStack()
        }
    }
}

struct NormalPostView_Previews: PreviewProvider {
    static var previews: some View {
        NormalPostView()
    }
}

struct PostHeadView: View {
    
    var body: some View {
        HStack {
            ProfileImage(buttonSize: 50, imageSize: 20)
            
            VStack(alignment: .leading) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Eliza Sanchez")
                        .foregroundColor(Color.gray99)
                        .font(.callout)
                })
                Text("2 min ago")
                    .foregroundColor(Color.gray79)
                    .font(.caption)
            }
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color.gray79)
                    
                }
            })
            .frame(width: 50, height: 50, alignment: .center)
        }
    }
}

struct ButtonHStack: View {
    
    private let likeButtonColor = Color.baseColor
    private let shareButtonColor = Color(.sRGB, red: 69/255, green: 142/255, blue: 255/255, opacity: 1)
    
    @State private var liked = false
    @State private var shared = false
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                likeButtonAction()
            }, label: {
                HStack {
                    Image(systemName: "suit.heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(liked ? likeButtonColor : .gray79)
                        .padding(.trailing, 5)
                    
                    Text("61")
                        .foregroundColor(Color.gray79)
                }
            })
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color.gray79)
                        .padding(.trailing, 5)
                    
                    Text("147")
                        .foregroundColor(Color.gray79)
                }
            })
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                shareButtonAction()
            }, label: {
                HStack {
                    Image(systemName: "arrowshape.bounce.right.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(shared ? shareButtonColor : .gray79)
                        .padding(.trailing, 5)
                        
                    
                    Text("1")
                        .foregroundColor(Color.gray79)
                }
            })
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .padding(.top, 5)
    }
    
    private func likeButtonAction() {
        liked.toggle()
    }
    
    private func shareButtonAction() {
        shared.toggle()
    }
}



private struct MainBody: View {
    
    @State private var bodyText = "He turned in the research paper on Friday; otherwise, he would have not passed the class."
    
    var body: some View {
        VStack {
            Text(bodyText)
                .font(setFont(text: bodyText))
            // TODO: - Remove Range Block
            if (Int.random(in: 0..<10)) % 2 == 0 { // Temp
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("placeholder-photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 180, alignment: .center)
                        .cornerRadius(6)
                        .clipped()
                })
            }
        }
    }
    
    func setFont(text: String) -> Font? {
        if text.count <= 50 {
            return .title
        }
        
        if text.count <= 80 {
            return .title2
        }
        
        return .title3
    }
}
