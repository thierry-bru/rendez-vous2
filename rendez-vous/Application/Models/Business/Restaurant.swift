//
//  Restaurant.swift
//  rendez-vous
//
//  Created by Thierry BRU on 15/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftHash
import MapKit


class Restaurant:NSObject {
   
    static var sharedInstance: Restaurant?
    //idRestaurant     libelle     raisonSociale     adresse     ville     codePostal     telephone     latitude     longitude     urlSite     pourcentReduction
    var idRestaurant = 0
    var libelle = ""
    var raisonSociale = ""
    var adressse = ""
    var ville = ""
    var codePostal = ""
    var telephone = ""
    var latitude = 0.0
    var longitude = 0.0
    var urlSite = ""
    var urlPhoto = ""
    var pourcentReduction = 0
    var indice = 0
    
    init(idRestaurant:Int,libelle:String,raisonSociale:String,adresse:String,ville:String, codePostal:String,telephone:String,latitude:Double,longitude:Double,urlSite:String,   urlPhoto:String,pourcentReduction:Int) {
        print("Restaurant:init (id:\(idRestaurant)")
        self.idRestaurant = idRestaurant
        self.libelle = libelle
        self.raisonSociale = raisonSociale
        self.adressse = adresse
        self.ville = ville
        self.codePostal = codePostal
        self.telephone = telephone
        self.latitude = latitude
        self.longitude = longitude
        self.urlSite = urlSite
        self.urlPhoto = urlPhoto
        self.pourcentReduction = pourcentReduction
    }
    convenience init(json:JSON) {
        self.init(idRestaurant:json["idRestaurant"].intValue,
                  libelle:json["libelle"].stringValue,
                  raisonSociale:json["raisonSociale"].stringValue,
                  adresse:json["adressse"].stringValue,
                  ville:json["ville"].stringValue,
                  codePostal:json["codePostal"].stringValue,
                  telephone:json["telephone"].stringValue,
                  latitude:json["latitude"].doubleValue,
                  longitude:json["longitude"].doubleValue,
                  urlSite:json["urlSite"].stringValue,
                  urlPhoto:json["urlPhoto"].stringValue,
                  pourcentReduction:json["pourcentReduction"].intValue)
    }
   
    
   
}
extension Restaurant:MKAnnotation
{
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: self.latitude)!, longitude: CLLocationDegrees(exactly: self.longitude)!)
    }
    var title: String? {return self.libelle}
    var subtitle: String? {return "-\(self.pourcentReduction)%"}
}
extension Restaurant:RestaurantListable
{
    static func load(datasource:RestaurantDataSource,latitude: Double, longitude: Double, range: Int) {
        print("Restaurant:RestaurantListable:load (\(latitude):\(longitude) - \(range))")
        let webservice = WebServiceRestaurant(commande: .LIST, entite: .Restaurant, datasource: datasource)
        webservice.addParameter(parametre: WebServiceParametre(cle: "distance", valeur: "\(range)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "latitude", valeur: "\(latitude)"))
        webservice.addParameter(parametre: WebServiceParametre(cle: "longitude", valeur: "\(longitude)"))
        webservice.execute()
    }
    
    
}
