//
//  ContentView.swift
//  Shared
//
//  Created by Ewa Szyszka on 2023/01/14.
//

import SwiftUI
import CoreLocation
import MapKit
import CoreData






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
                                        Image("start").resizable().frame(width: 100, height: 100)
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




class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager = CLLocationManager()
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.longitude = location.coordinate.longitude
        self.latitude = location.coordinate.latitude
    }
}


//Second screen
struct DetailView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State var longitude: Double = 0.0
    @State var latitude: Double = 0.0
    @ObservedObject var locationManager = LocationManager()
    
    
    var body: some View {
        
        Text("Longitude: \(locationManager.longitude)")
        Text("Latitude: \(locationManager.latitude) ")
    }
        
        /*
        Map(coordinateRegion: $viewModel.region, showsUserLocation:  true).accentColor(Color(.systemPink))
            .onAppear{
            viewModel.checkIfLocationServiceIsEnabled()
        } */
        
    }














/* Trying core data*/
struct CoreDataStack {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ModelName")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    static var context: NSManagedObjectContext { return persistentContainer.viewContext }
}

/* core data end*/











final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:37.331516, longitude:-121.891054 ), span:  MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
    
    
    var locationManager: CLLocationManager?
    
    
    func checkIfLocationServiceIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
            locationManager?.startUpdatingLocation()
            
        }else{
            print("Show an alert that location tracking is switched off")
        }
    }
    
    /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation], fromLocation oldLocation: CLLocation!) {
        guard let location = locationManager?.location else { return }
        let context = CoreDataStack.context
        let userLocation = UserLocation(context: context)
        userLocation.latitude = location.coordinate.latitude
        userLocation.longitude = location.coordinate.longitude

    }
   */
         
    
   
    
    
    
    
    
    /* Checking if the user has the localization authorization on the phone*/
    func checkLocationAuthorization(){
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus{
            
        case.notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case.restricted:
            print("Your location is restricted")
        case.denied:
            print("Go to settings to allow location permission")
        case.authorizedAlways:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,                                               span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        case.authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,                                               span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }
    }
    
    /* This function checks if the user changed the permissions for localization*/
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}



//Start the app from the first screen
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

