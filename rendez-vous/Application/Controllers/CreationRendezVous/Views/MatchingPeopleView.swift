//
//  MatchingPeopleView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 26/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import UIKit

class MatchingPeopleView: UIView
{
    var currentControleur : CreateGroupViewController?
    
    @IBOutlet weak var GuestRankedTable: GuestRankedTableView!
    // liste des invités dans le groupe
    @IBOutlet weak var guestInvitedCollection: GuestCollectionView!
    
    func show(controleur:CreateGroupViewController)
    {
        print("MatchingPeopleView:show")
        self.isHidden = false
        self.currentControleur!.listeMesMatchs!.getPurgedList(rendezVous: self.currentControleur!.currentRendezVous!, hote:Utilisateur.sharedInstance!)
        self.currentControleur!.viewMatchingPeople.GuestRankedTable.refresh()
        
    // création du lien entre la collection des invités et la source de données des invités
    self.guestInvitedCollection.delegate = self.guestInvitedCollection
    self.guestInvitedCollection.dataSource = self.guestInvitedCollection
  
    
    // création du lien entre la liste des gens pouvant être invité et la table permettant de les choisir
    self.GuestRankedTable.delegate = self.GuestRankedTable
    self.GuestRankedTable.dataSource = self.GuestRankedTable
    self.GuestRankedTable.refresh()
    
   // currentControleur!.listeMesMatchs!.subscribe(vue: self.GuestRankedTable)
    //ListeMatchingUtilisateurs.load(controleur: controleur)
    //Utilisateur.load(datasource: self, latitude: LocationManager.SharedInstance.location!.coordinate.latitude, longitude: LocationManager.SharedInstance.location!.coordinate.longitude, range: 10)
    }
    
}
/*extension MatchingPeopleView:UtilisateurDataSource
{
    func utilisateurOnLoaded(utilisateur: Utilisateur) {
        print("MatchingPeopleView:UtilisateurDataSource:utilisateurOnLoaded NON IMPLEMENTED")
    }
    
    func utilisateurOnLoaded(matchs: ListeMatchingUtilisateurs) {
        print("MatchingPeopleView:UtilisateurDataSource:utilisateurOnLoaded")
        currentControleur!.listeMesMatchs = matchs
       // currentControleur!.listeMesMatchs!.reloadViews()
    }
    
    func utilisateurOnUpdated() {
        print("MatchingPeopleView:UtilisateurDataSource:utilisateurOnLoaded NON IMPLEMENTED")
    }
    
    func utilisateurOnDeleted() {
        print("MatchingPeopleView:UtilisateurDataSource:utilisateurOnLoaded NON IMPLEMENTED")
    }
    
    func utilisateurOnCreated() {
        print("MatchingPeopleView:UtilisateurDataSource:utilisateurOnLoaded NON IMPLEMENTED")
    }
    
    func utilisateurOnNotFoundUtilisateur() {
        print("MatchingPeopleView:UtilisateurDataSource:utilisateurOnLoaded NON IMPLEMENTED")
    }
    
    func utilisateurOnWebServiceError(code: Int) {
        print("MatchingPeopleView:UtilisateurDataSource:utilisateurOnLoaded")
        AlerteBoxManager.sendAlertMessage(vc: self.currentControleur!, returnCode: code)
    }
    
    
}*/
