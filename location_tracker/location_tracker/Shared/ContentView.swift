//
//  ContentView.swift
//  Shared
//
//  Created by Ewa Szyszka on 2023/01/14.
//

import SwiftUI
import CoreLocation
import MapKit






//Landing page screen
struct ContentView: View {
    
@State var titleBook = ""
   @State var author = ""
   @State var isExchange: Bool = true
   @State private var categoryIndex = 0
   var categorySelection = ["慶應義塾", "KMD student","社会人"]
       
    
    var body: some View {
    
        NavigationView {
        Form {
            
            Section(header: Text("Personal info")) {
                               TextField("名前", text: $titleBook)
                               TextField("名字", text: $author)
                               Toggle(isOn: $isExchange) {
                                   Text("参加することに同意します")
                               }
                           }
            
            Section() {
                           Picker(selection: $categoryIndex, label: Text("所属")) {
                               ForEach(0 ..< categorySelection.count) {
                                   Text(self.categorySelection[$0])
                               }
                           }
                       }


            VStack{
              
                NavigationLink(destination: DetailView()) {
                                    HStack {
                                        Image("スタート").resizable().frame(width: 100, height: 100)
                                        Text("スタート")
                                    }
                                }
            }
        }.navigationTitle("ユーザー調査")
            
 
            VStack{
              
                NavigationLink(destination: DetailView()) {
                                    HStack {
                                        Image("start").resizable().frame(width: 100, height: 70)
                                        Text("Click Me!")
                                    }
                                }
            }
                
            
        }
    }
}






//Second screen
struct DetailView: View {
    
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:37.331516, longitude:-121.891054 ), span:  MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    
    var body: some View {
        Text("This is the Detail View")
        Map(coordinateRegion: $region, showsUserLocation: true)
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
