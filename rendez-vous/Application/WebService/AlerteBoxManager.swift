
//
//  AlerteBoxManager.swift
//  rendez-vous
//
//  Created by Thierry BRU on 07/08/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import Foundation
import UIKit

class AlerteBoxManager
{
    static func generateMessageAlert(returnCode: Int)-> String {
        let message: String
        switch returnCode
        {
        case 1: message = "Vous allez maintenant recevoir un courriel contenant votre code de validation à 6 chiffes."
            
        case 301: message = "La connexion internet n'est pas disponible: \(returnCode)"
        case 200: message = "La connexion a réussi. Bienvenue."
            
        case 400: message = "La requête est mal formulée: \(returnCode)"
        case 401: message = "Votre identifiant ou votre mot de passe est incorrect: \(returnCode)"
        case 403: message = "Signature de la requête invalide: \(returnCode)"
        case 405: message = "Cette requête a déjà été envoyée: \(returnCode)"
        default: message = "Erreur indéterminée: \(returnCode)"
        }
        return message
    }
    static func generateTitleAlert(vc:RamonViewController)->String
    {
        var title : String
        switch vc.codeController {
        case "RegisterVC": title = "Creating Account"
        case "AuthentificationVC": title = "Authentification"
        default:
            title = "Alert"
        }
        return title
    }
    
    static func sendAlertMessage(vc:UIViewController,returnCode:Int)
    {
        let message = generateMessageAlert(returnCode: returnCode)
        let view = vc as!RamonViewController
        let title = generateTitleAlert(vc: view)
        let alert : UIAlertController = UIAlertController(title: title, message: "\(message)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
