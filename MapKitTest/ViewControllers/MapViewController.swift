//
//  MapViewController.swift
//  MapKitTest
//
//  Created by User on 20.01.2021.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: GMSMapView!
    
    var arrayOfCoordinate = [Place]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showCurrentLocationOnMap()
                self.tableView.reloadData()
            }
        }
    }
    
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = email
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
    }
    
    func showCurrentLocationOnMap(){
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        let position = GMSCameraPosition.camera(withLatitude: 50.4475888, longitude: 30.5198317, zoom: 14)
        mapView.camera = position
        
        for data in arrayOfCoordinate{
            let location = CLLocationCoordinate2D(latitude: data.lat, longitude: data.lng)
            let marker = GMSMarker()
            marker.position = location
            marker.snippet = data.name
            marker.map = mapView
        }
    }
    
    func fetchData() {
        NetworService.shared.loadPlaces { response in
            
            switch response {
            case let .Value(place):
                self.arrayOfCoordinate = place.places
                
            case let .Error(error):
                print(error)
            }
        }
    }
}

extension MapViewController: UITableViewDelegate {}
extension MapViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCoordinate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }
        let places = arrayOfCoordinate[indexPath.row]
        
        cell.customizeCell(place: places)
        return cell
    }
}
