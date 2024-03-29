//
//  CreateGroupViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 19/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON
/*
 L'utilisateur peut créer via ce controleur un groupe pour aller dans un restaurant donné
 il a choisi a priori le groupe, avant d'arriver dans ce contrôleur
 */
class CreateGroupViewController: RamonViewController {
    
    var mode = "create"
    var listeMesMatchs: ListeMatchingUtilisateurs?
    var currentRendezVous:RendezVous?

   // var currentRestaurant: Restaurant?
    // infos pour remplir la vue du groupe
    @IBOutlet weak var ficheRendezVous: RendezVousView!
    @IBOutlet weak var listeInvitesRDV: GuestCollectionView!
    
    
    //liste des personnes qui matchent (distance + note ranking)
    //vues et contraintes
    @IBOutlet weak var vieuwButtonCreateGroupe: UIView!
    @IBOutlet weak var viewMatchingPeople: MatchingPeopleView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("currentRestaurant:viewDidLoad")
        // Do any additional setup after loading the view.
        // mise a jour du panel d'info sur le restaurant choisi: il y a forcément un restaurant choisi!
        self.ficheRendezVous.update(restaurant:Restaurant.sharedInstance!,controleur: self)
        RendezVous.subscribe(vue: self.ficheRendezVous)
        RendezVous.subscribe(vue: self.listeInvitesRDV)
        self.viewMatchingPeople.currentControleur = self
        self.viewMatchingPeople.GuestRankedTable.currentControleur = self
        self.viewMatchingPeople.guestInvitedCollection.currentControleur = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("CreateGroupViewController: viewWillAppear")
        // Est ce qu'il y a un rendez-vous qui a été déjà créé?
      // bug, ca prend le dernier dans la liste à l'indice donné
        print("->Lancement rechargement de la liste des gens qui matchent")
        Utilisateur.load(datasource: self, latitude: Utilisateur.sharedInstance!.latitude, longitude: Utilisateur.sharedInstance!.longitude, range: 10)
        /* if self.mode != "create"
            {
                print("let rendez vous")
                ficheRendezVous.setRendezVous(rendezVous: RendezVous.sharedInstance!)
                  self.viewMatchingPeople.show(controleur: self)
            }*/
        if let rdv = currentRendezVous
        {
            print("--> Modification d'un rendez-vous existant")
            //ficheRendezVous.setRendezVous(rendezVous: RendezVous.sharedInstance!)
            ficheRendezVous.setRendezVous(rendezVous: rdv)
            self.viewMatchingPeople.show(controleur: self)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("MapRestaurantViewController:viewWillDisappear")
        RendezVous.unsuscribe(vue: self.ficheRendezVous)
        RendezVous.unsuscribe(vue: self.listeInvitesRDV)
        print(self)
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("MapRestaurantViewController:viewDidDisappear")
        print(self)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func onClickClose(_ sender: RoundButtonUIButton) {
        print("CreateGroupViewController: onClickClose")
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension CreateGroupViewController:UtilisateurDataSource
{
    
    func utilisateurOnLoaded(utilisateur: Utilisateur) {
        print("CreateGroupViewController:UtilisateurDataSource:utilisateurOnLoaded - NOT IMPLEMENTED")
    }
    
    func utilisateurOnLoaded(matchs: ListeMatchingUtilisateurs) {
        print("CreateGroupViewController:UtilisateurDataSource:utilisateurOnLoaded")
        print("->Chargement des \(matchs.liste.count) matchs")
       // matchs.liste = matchs.getPurgedList()
        self.listeMesMatchs = matchs        
    }
    
    func utilisateurOnUpdated() {
        print("CreateGroupViewController:UtilisateurDataSource:utilisateurOnLoaded - NOT IMPLEMENTED")
    }
    
    func utilisateurOnDeleted() {
        print("CreateGroupViewController:UtilisateurDataSource:utilisateurOnLoaded - NOT IMPLEMENTED")
    }
    
    func utilisateurOnCreated() {
        print("CreateGroupViewController:UtilisateurDataSource:utilisateurOnLoaded - NOT IMPLEMENTED")
    }
    
    func utilisateurOnNotFoundUtilisateur() {
        print("CreateGroupViewController:UtilisateurDataSource:utilisateurOnLoaded - NOT IMPLEMENTED")
    }
    
    func utilisateurOnWebServiceError(code: Int) {
        print("CreateGroupViewController:UtilisateurDataSource:utilisateurOnLoaded - NOT IMPLEMENTED")
    }
    
}
