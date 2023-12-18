//
//  habit_category_selection_screen.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/12/23.
//

import SwiftUI

struct habit_category_selection_screen: View {
    var body: some View {
        ZStack
        {
            // Gradient background
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#15313F"), Color(hex: "#04080B")]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("What Would You Like To Work On?")
                    .foregroundColor(.yellow)
                Button(action: {
                    print("Button tapped")
                }) {
                    ZStack {
                        Image("habit_item")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 100)
                        
                        HStack {
                            Image("health")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.leading,10)
                            
                            Spacer()
                            
                            
                            Text("Health & Fitness")
                                .padding(.trailing, 25)
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            
                            Spacer()
                        }
                        .frame(width: 350, height: 100)
                    }
                }
                Button(action: {
                
                    print("Button tapped")
                }) {
                    ZStack {
                        Image("habit_item")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 100)
                        
                        HStack {
                            Image("mindfulness")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.leading,10)
                            
                            Spacer()
                            
                            
                            Text("Mindfulness & Well-being")
                                .padding(.trailing, 25)
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            
                            Spacer()
                        }
                        .frame(width: 350, height: 100)
                    }
                }
                Button(action: {
                    print("Button tapped")
                }) {
                    ZStack {
                        Image("habit_item")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 100)
                        
                        HStack {
                            Image("learning")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.leading,10)
                            
                            Spacer()
                            
                            
                            Text("Learning & Growth")
                                .padding(.trailing, 25)
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            
                            Spacer()
                        }
                        .frame(width: 350, height: 100)
                    }
                }
                Button(action: {
                    print("Button tapped")
                }) {
                    ZStack {
                        Image("habit_item")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 100)
                        
                        HStack {
                            Image("creativity")                                 .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.leading,10)
                            
                            Spacer()
                            
                            
                            Text("Creativity & Expression")
                                .padding(.trailing, 25)
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            
                            Spacer()
                        }
                        .frame(width: 350, height: 100)
                    }
                }
                Button(action: {
                    print("Button tapped")
                }) {
                    ZStack {
                        Image("habit_item")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 100)
                        
                        HStack {
                            Image("adventure")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.leading,10)
                            
                            Spacer()
                            
                            
                            Text("Adventure & Exploration")
                                .padding(.trailing, 25)
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            
                            Spacer()
                        }
                        .frame(width: 350, height: 100)
                    }
                }
                Text("or")
                    .foregroundColor(.yellow)
                
                Button(action: {
                }) {
                    HStack {
                        Image("default_icon")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.leading,10)
                        Spacer()
                        Text("Create Your Own")
                            .padding(.trailing, 25)
                            .foregroundColor(.black)
                            .font(.headline)


                                            
                        Spacer()
                    }
                }
                .frame(width: 329, height: 66)
                .background(Color(red: 0.995, green: 0.744, blue: 0.013))
                .cornerRadius(30) 
                .padding(.bottom, 60)
                
                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color("YourGradientStartColor"), Color("YourGradientEndColor")]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
    }
    }
                    
           
        
        
            
        
struct habit_category_selection_screen_Previews: PreviewProvider {
    static var previews: some View {
        habit_category_selection_screen()
    }
}
