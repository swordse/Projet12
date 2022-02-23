//
//  NetworkError.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 07/02/2022.
//
import Foundation
/// enum to keep track of the networkError
enum NetworkError: String, Error {
    case noData = "Aucune donnée."
    case noConnection = "Vérifiez votre connexion internet."
    case errorOccured = "Une erreur est survenue. Veuillez réessayer."
    case invalidEmail = "L'email n'est pas valide."
    case emailAlreadyUsed = "Cet email est déjà utilisé."
    case wrongPassWord = "Le mot de passe ne correspond pas à l'email."
}
