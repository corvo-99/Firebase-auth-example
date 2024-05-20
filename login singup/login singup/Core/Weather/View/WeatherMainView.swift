//
//  WeatherMainView.swift
//  login singup
//
//  Created by Dylan Corvo on 20/05/24.
//

import SwiftUI

struct WeatherMainView: View {
    @ObservedObject private var locationViewModel = LocationViewModel()
    @ObservedObject var weatherViewModel = WeatherViewModel()
    var body: some View {
        let dayWeather = weatherViewModel.dayWeather
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.orange, .clear], startPoint: .top, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack {
                    ScrollView{
                        //image
                        Image("userlogo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .padding(.vertical, 32)
                        //                    Text("Current Location: \(String(describing: locationViewModel.location))")
                        //                    Text(dayWeather?.currentTemperature.formatted() ?? "?°")
                        if let dayWeather = weatherViewModel.dayWeather {
                            
                            VStack{
                                Text(" \(dayWeather.currentTemperature.formatted())")
                                    .font(.system(size: 75, weight: .bold))
                                HStack{
                                    Text("H: \(dayWeather.highTemperature.formatted())")
                                        .fontWeight(.semibold)
                                    Text("L: \(dayWeather.lowTemperature.formatted())")
                                        .fontWeight(.semibold)
                                }
                            }
                            VStack(alignment: .leading){
                                Text("Feels like: \(dayWeather.currentFeelsLikeTemperature.formatted())")
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding()
                                Text("Precipitation: \(dayWeather.precipitationChance.formatted())%")
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding()
                                Text("Ammount of Rain: \(dayWeather.rainfallAmount.formatted())")
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding()
                                //                Text("Daily Wind: \(dayWeather.wind)")
                                //                    .padding()
                            }
                        }
                    }
                    ButtonActionLabel(action:{
                        weatherViewModel.fetchCurrentWeather()
                        print("Fetching current weather.")
                    },
                                      title: "Fetch Weather",
                                      imageSFSymbol: "")
                    .padding(.top, 24)
//                    .onAppear(perform: {
//                        weatherViewModel.fetchCurrentWeather()
//                        print("Fetching current weather.")
//                    })
                }.padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Weather")
                        .font(.system(size: 34, weight: .heavy))
                }
                ToolbarItem(placement: .principal) {
                    Text("")  // Needed to make the normal title disappear
                }
                ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            ProfileView(email: .constant(""))
                        } label: {
                            Image(systemName: "gear")
                                .tint(.white)
                                .symbolRenderingMode(.monochrome)
                        }
                }
            }
            .navigationTitle("Weather")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    WeatherMainView()
}
