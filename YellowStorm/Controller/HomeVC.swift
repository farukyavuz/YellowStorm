//
//  HomeVC.swift
//  YellowStorm
//
//  Created by Faruk Yavuz on 17.03.2018.
//  Copyright © 2018 Faruk Yavuz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RevealingSplashView
import Firebase

enum AnnotationType {
    case pickup
    case destination
    case driver
}
enum ButtonAction {
    case requestRide
    case getDirectionsToPassenger
    case getDirectionsToDestination
    case startTrip
    case endTrip
}

class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    @IBOutlet weak var centerMapBtn: UIButton!
    @IBOutlet weak var destinationTextField: UITextField!
//    @IBOutlet weak var destinationCircle: CircleView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var delegate: CenterVCDelegate?
    var manager: CLLocationManager?
//    var currentUserId = Auth.auth().currentUser?.uid
    var regionRadius: CLLocationDistance = 1000
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!,
                                                  iconInitialSize: CGSize(width: 80, height: 80),
                                                  backgroundColor: UIColor.white)
    var tableView = UITableView()
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var route: MKRoute?
    var selectedItemPlacemark: MKPlacemark? = nil
    var actionForButton: ButtonAction = .requestRide

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        manager = CLLocationManager()
//        manager?.delegate = self
//        manager?.desiredAccuracy = kCLLocationAccuracyBest
//
//        checkLocationAuthStatus()
//
//        mapView.delegate = self
//        destinationTextField.delegate = self
//
//        centerMapOnUserLocation()
//
//        DataService.instance.REF_DRIVERS.observe(.value, with: { (snapshot) in
//            self.loadDriverAnnotationsFromFB()
//
//            DataService.instance.passengerIsOnTrip(passengerKey: self.currentUserId!, handler: { (isOnTrip, driverKey, tripKey) in
//                if isOnTrip == true {
//                    self.zoom(toFitAnnotationsFromMapView: self.mapView, forActiveTripWithDriver: true, withKey: driverKey)
//                }
//            })
//        })
//
//        cancelBtn.alpha = 0.0
        
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.heartBeat
        revealingSplashView.startAnimation()
        
        revealingSplashView.heartAttack = true
        
//        UpdateService.instance.observeTrips { (tripDict) in
//            if let tripDict = tripDict {
//                let pickupCoordinateArray = tripDict[USER_PICKUP_COORDINATE] as! NSArray
//                let tripKey = tripDict[USER_PASSENGER_KEY] as! String
//                let acceptanceStatus = tripDict[TRIP_IS_ACCEPTED] as! Bool
//
//                if acceptanceStatus == false {
//                    DataService.instance.driverIsAvailable(key: self.currentUserId!, handler: { (available) in
//                        if let available = available {
//                            if available == true {
//                                let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: Bundle.main)
//                                let pickupVC = storyboard.instantiateViewController(withIdentifier: VC_PICKUP) as? PickupVC
//                                pickupVC?.initData(coordinate: CLLocationCoordinate2D(latitude: pickupCoordinateArray[0] as! CLLocationDegrees, longitude: pickupCoordinateArray[1] as! CLLocationDegrees), passengerKey: tripKey)
//                                self.present(pickupVC!, animated: true, completion: nil)
//                            }
//                        }
//                    })
//                }
//            }
//        }
    }
    
    
    
    func centerMapOnUserLocation() {
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
//        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
//        buttonSelector(forAction: actionForButton)
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
//        DataService.instance.driverIsOnTrip(driverKey: currentUserId!) { (isOnTrip, driverKey, tripKey) in
//            if isOnTrip == true {
//                UpdateService.instance.cancelTrip(withPassengerKey: tripKey!, forDriverKey: driverKey!)
//            }
//        }
//
//        DataService.instance.passengerIsOnTrip(passengerKey: currentUserId!) { (isOnTrip, driverKey, tripKey) in
//            if isOnTrip == true {
//                UpdateService.instance.cancelTrip(withPassengerKey: self.currentUserId!, forDriverKey: driverKey!)
//            } else {
//                self.removeOverlaysAndAnnotations(forDrivers: false, forPassengers: true)
//                self.centerMapOnUserLocation()
//            }
//        }
//
//        self.actionBtn.isUserInteractionEnabled = true
    }
    
    @IBAction func centerMapBtnWasPressed(_ sender: Any) {
//        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
//            if let userSnapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                for user in userSnapshot {
//                    if user.key == self.currentUserId! {
//                        if user.hasChild(TRIP_COORDINATE) {
//                            self.zoom(toFitAnnotationsFromMapView: self.mapView, forActiveTripWithDriver: false, withKey: nil)
//                            self.centerMapBtn.fadeTo(alphaValue: 0.0, withDuration: 0.2)
//                        } else {
//                            self.centerMapOnUserLocation()
//                            self.centerMapBtn.fadeTo(alphaValue: 0.0, withDuration: 0.2)
//                        }
//                    }
//                }
//            }
//        })
    }
    
    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
    }
    
    func buttonSelector(forAction action: ButtonAction) {
//        switch action {
//        case .requestRide:
//            if destinationTextField.text != "" {
//                UpdateService.instance.updateTripsWithCoordinatesUponRequest()
//                actionBtn.animateButton(shouldLoad: true, withMessage: nil)
//                cancelBtn.fadeTo(alphaValue: 1.0, withDuration: 0.2)
//
//                self.view.endEditing(true)
//                destinationTextField.isUserInteractionEnabled = false
//            }
//        case .getDirectionsToPassenger:
//            DataService.instance.driverIsOnTrip(driverKey: currentUserId!, handler: { (isOnTrip, driverKey, tripKey) in
//                if isOnTrip == true {
//                    DataService.instance.REF_TRIPS.child(tripKey!).observe(.value, with: { (tripSnapshot) in
//                        let tripDict = tripSnapshot.value as? Dictionary<String, AnyObject>
//
//                        let pickupCoordinateArray = tripDict?[USER_PICKUP_COORDINATE] as! NSArray
//                        let pickupCoordinate = CLLocationCoordinate2D(latitude: pickupCoordinateArray[0] as! CLLocationDegrees, longitude: pickupCoordinateArray[1] as! CLLocationDegrees)
//                        let pickupMapItem = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate))
//
//                        pickupMapItem.name = MSG_PASSENGER_PICKUP
//                        pickupMapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
//                    })
//                }
//            })
//        case .startTrip:
//            DataService.instance.driverIsOnTrip(driverKey: self.currentUserId!, handler: { (isOnTrip, driverKey, tripKey) in
//                if isOnTrip == true {
//                    self.removeOverlaysAndAnnotations(forDrivers: false, forPassengers: false)
//
//                    DataService.instance.REF_TRIPS.child(tripKey!).updateChildValues([TRIP_IN_PROGRESS: true])
//
//                    DataService.instance.REF_TRIPS.child(tripKey!).child(USER_DESTINATION_COORDINATE).observeSingleEvent(of: .value, with: { (coordinateSnapshot) in
//                        let destinationCoordinateArray = coordinateSnapshot.value as! NSArray
//                        let destinationCoordinate = CLLocationCoordinate2D(latitude: destinationCoordinateArray[0] as! CLLocationDegrees, longitude: destinationCoordinateArray[1] as! CLLocationDegrees)
//                        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
//
//                        self.dropPinFor(placemark: destinationPlacemark)
//                        self.searchMapKitForResultsWithPolyline(forOriginMapItem: nil, withDestinationMapItem: MKMapItem(placemark: destinationPlacemark))
//                        self.setCustomRegion(forAnnotationType: .destination, withCoordinate: destinationCoordinate)
//
//                        self.actionForButton = .getDirectionsToDestination
//                        self.actionBtn.setTitle(MSG_GET_DIRECTIONS, for: .normal)
//                    })
//                }
//            })
//        case .getDirectionsToDestination:
//            DataService.instance.driverIsOnTrip(driverKey: self.currentUserId!, handler: { (isOnTrip, driverKey, tripKey) in
//                if isOnTrip == true {
//                    DataService.instance.REF_TRIPS.child(tripKey!).child(USER_DESTINATION_COORDINATE).observe(.value, with: { (snapshot) in
//                        let destinationCoordinateArray = snapshot.value as! NSArray
//                        let destinationCoordinate = CLLocationCoordinate2D(latitude: destinationCoordinateArray[0] as! CLLocationDegrees, longitude: destinationCoordinateArray[1] as! CLLocationDegrees)
//                        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
//                        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
//
//                        destinationMapItem.name = MSG_PASSENGER_DESTINATION
//                        destinationMapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
//                    })
//                }
//            })
//        case .endTrip:
//            DataService.instance.driverIsOnTrip(driverKey: self.currentUserId!, handler: { (isOnTrip, driverKey, tripKey) in
//                if isOnTrip == true {
//                    UpdateService.instance.cancelTrip(withPassengerKey: tripKey!, forDriverKey: driverKey!)
//                    self.buttonsForDriver(areHidden: true)
//                }
//            })
//        }
    }


}











