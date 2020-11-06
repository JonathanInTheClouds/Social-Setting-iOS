//
//  ProfileView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/17/20.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.tertiarySystemBackground.ignoresSafeArea()
                ScrollView {
                    LazyVStack {
                        // TODO: - Add Functionality
                        ProfileInfo()
                            .padding(.bottom, 25)
                            .padding(.top, 10)
                        Separator()
                        ForEach(1...20, id: \.self) { value in
                            PostContentView(post: .constant(PostResponseModel(id: 1,
                                                                              publicUserId: "",
                                                                              postName: "Openly admit that you don't know something", url: nil,
                                                                              description: "If you don't have any knowledge about the topic, admit it openly that you don't know.",
                                                                              userName: "MettaworldJ", subSettingName: "", duration: "just not", upVote: true, downVote: false,
                                                                              voteCount: 61, commentCount: 147)))
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .onAppear(perform: {
                                    print(value)
                                })
                            Separator()
                        }
                    }
                    .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
            }
            .onAppear(perform: {
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.gray99)]
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("@fcbarcelona")
            .navigationBarItems(trailing: Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 23, alignment: .center)
            }))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
                .environment(\.colorScheme, .light)
            ProfileView()
                .environment(\.colorScheme, .dark)
        }
    }
}

private struct HeadView: View {
    var body: some View {
        HStack(spacing: 13) {
            ProfileImage()
            
            VStack(alignment: .leading, spacing: 3) {
                Text("FC Barcelona")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.gray99)
                Text("Software Engineer")
                    .font(.footnote)
                    .foregroundColor(Color.gray79)
            }
            
            Spacer()
            
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ZStack {
                        Color.gray19
                        Image(systemName: "quote.bubble.fill")
                            .foregroundColor(Color.gray79)
                    }.frame(width: 42, height: 42, alignment: .center)
                }).clipShape(Circle())
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ZStack {
                        Color.gray19
                        Image(systemName: "plus")
                            .foregroundColor(Color.gray79)
                    }.frame(width: 42, height: 42, alignment: .center)
                }).clipShape(Circle())
            }
        }
    }
}

private struct BodyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("The best thing about a boolean is even if you are wrong, you are only off by a bit.")
                .foregroundColor(Color.gray99)
                .padding(.bottom, 5)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("mettaworldj.com")
                    .bold()
                    .foregroundColor(Color.baseColor)
            })
        }
    }
}

private struct FootView: View {
    var body: some View {
        HStack(spacing: 1) {
            ProfileInfoButton(title: "Posts", count: 781)
            ProfileInfoButton(title: "Followers", count: 290)
            ProfileInfoButton(title: "Following", count: 45)
        }
        .frame(height: 70, alignment: .center)
        .cornerRadius(6)
    }
}

private struct ProfileInfoButton: View {
    
    @State var title: String
    
    @State var count: Int
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            ZStack {
                Color.gray19
                VStack(spacing: 2.5) {
                    Text("\(count)")
                        .bold()
                        .foregroundColor(Color.gray99)
                    Text("\(title)")
                        .font(.footnote)
                        .foregroundColor(Color.gray79)
                }
            }
        })
    }
}

struct ProfileInfo: View {
    var body: some View {
        VStack {
            HeadView()
                .padding(.bottom, 10)
            BodyView()
                .padding(.bottom, 24)
            FootView()
        }
        .padding(.horizontal, 16)
    }
}

