//
//  MapViewController.swift
//  [Project] BookFinder
//
//  Created by Apple on 2/27/20.
//  Copyright © 2020 Hieu Le. All rights reserved.
//

import UIKit
import MapKit
//import GooglePlaces
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    /*var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?*/
    
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*setupSearchController()
        resultsViewController?.delegate = self*/
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
            case 0:
                mapView.mapType = .standard
            default:
                mapView.mapType = .hybrid
        }
    }
    
    
    /*
    func setupSearchController() {
        resultsViewController = GMSAutocompleteResultsViewController()

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = searchController?.searchBar
        definesPresentationContext = true
        searchController?.hidesNavigationBarDuringPresentation = false
    }*/
    
}


/*
extension MapViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsCOntroller: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        
        searchController?.isActive = false
        
        mapView.removeAnnotations(mapView.annotations)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: place.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = place.coordinate
        annotation.title = place.name
        annotation.subtitle = place.formattedAddress
        mapView.addAnnotation(annotation)
    }
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}*/

