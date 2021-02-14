//
//  MapView.swift
//  GeoFoodIOS
//
//  Created by Егор on 15.01.2021.
//

import SwiftUI
import MapKit

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var currentLocation = CLLocationCoordinate2D()
    @State var center = CLLocationCoordinate2D()
    @State var isUserInCenter: Bool = false
    private let client = ServerClient()
    @Binding var token: String?
    let locationManager = LocationManager()
    var body: some View {
        ZStack(alignment: .topTrailing){
            MapView(centerCoordinate: $center, currentLocation: $currentLocation, isUserInCenter: $isUserInCenter)
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                    self.setCurrentLocation()
                })
            VStack{
                ZStack{
                    Button(action: setCurrentLocation, label: {
                        Image(systemName: "location")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .padding(2)
                    })
                }
                .frame(width: 30, height: 30, alignment: .center)
                .padding(5)
                .background(Color.white)
                .cornerRadius(50)
                .shadow(color: .black, radius: 1.5, x: 0.0, y: 0.0)
                Button("Выйти") {
                    UserDefaults.standard.removeObject(forKey: "geofoodToken")
                    token = nil
                    return
                }
                .foregroundColor(.red)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            client.getUserInfo(token: token!) { userInfo in
                guard let userInfo = userInfo else {
                    self.token = nil
                    UserDefaults.standard.removeObject(forKey: "geofoodToken")
                    return
                }
                self.setCurrentLocation()
                print(userInfo)
            }
        }
    }
    
    func setCurrentLocation(){
        let lat = locationManager.location?.coordinate.latitude ?? 0
        let long = locationManager.location?.coordinate.longitude ?? 0
        currentLocation.latitude = lat
        currentLocation.longitude = long
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(token: "")
//    }
//}
