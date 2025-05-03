
//  FirebaseFunctions.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 03/05/2025.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore

//MARK: Authentication
func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(.failure(error))
        } else if let user = authResult?.user {
            completion(.success(user))
        }
    }
}

func signUp(name: String, email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(.failure(error))
        } else if let user = authResult?.user {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { commitError in
                if let commitError = commitError {
                    completion(.failure(commitError))
                } else {
                    completion(.success(user))
                }
            }
        }
    }
}

//Google authentication

func signInWithGoogle(presenting: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
    guard let clientID = FirebaseApp.app()?.options.clientID else {
        completion(.failure(NSError(domain: "MissingClientID", code: -1)))
        return
    }

    let config = GIDConfiguration(clientID: clientID)

    GIDSignIn.sharedInstance.signIn(with: config, presenting: presenting) { user, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let user = user else {
            completion(.failure(NSError(domain: "MissingUser", code: -1)))
            return
        }

        let authentication = user.authentication
        let idToken = authentication.idToken
        let accessToken = authentication.accessToken

        let credential = GoogleAuthProvider.credential(withIDToken: idToken ?? "", accessToken: accessToken)

        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }
}
