//
//  FirebaseAuthService.swift
//  iOS-Again
//
//  Created by DDang on 2023/04/01.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import CryptoKit
import AuthenticationServices

protocol FirebaseAuthServiceDelegate {
    func didSNSSignup(_ result: AuthDataResult)
}

/// Firebase Authentication을 사용하여 Social 사용자를 인증
/// - Author: 김민규
/// - Date: 2023/04/02
class FirebaseAuthService: NSObject {
    fileprivate var currentNonce: String?
    private weak var viewController: UIViewController?
    
    var delegate: FirebaseAuthServiceDelegate?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    /// 이메일을 통한 인증
    /// - Parameters:
    ///     - email: 이메일 주소
    ///     - password: 패스워드 rawString
    ///     - completion: 인증 절차 진행 후 실행 Closure
    /// - Author: 김민규
    /// - Date: 2023/04/02
    func emailSignup(email: String, password: String, completion: @escaping (AuthDataResult?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            guard error == nil else {
                print(error!)
                return completion(nil)
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    print(error!)
                    return completion(nil)
                }
                
                completion(result)
            }
        }
    }
    
    /// Social: Google을 통한 인증
    /// - Author: 김민규
    /// - Date: 2023/04/02
    func googleSignup() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController!) { result, error in
            guard error == nil else { return }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            // 사용자 정보 등록
            Auth.auth().signIn(with: credential) { result, _ in
                // 사용자 등록 후에 처리할 코드
                self.delegate?.didSNSSignup(result!)
            }
        }
    }

    /// Social: Apple을 통한 인증
    /// - Author: 김민규
    /// - Date: 2023/04/02
    @available(iOS 13.0, *)
    func appleSignup() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]   // 사용자의 이름, 이메일 주소를 요청
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

@available(iOS 13.0, *)
extension FirebaseAuthService: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return viewController!.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { (result, error) in
                if (error != nil) {
                    print(error!.localizedDescription)
                    return
                }
                
                self.delegate?.didSNSSignup(result!)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
    }
}

extension FirebaseAuthService {
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
