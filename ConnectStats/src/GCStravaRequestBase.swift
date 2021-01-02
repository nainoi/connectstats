//  MIT License
//
//  Created on 26/12/2020 for ConnectStats
//
//  Copyright (c) 2020 Brice Rosenzweig
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//



import UIKit
import OAuthSwift
import SwiftKeychainWrapper
import RZUtilsSwift

class GCStravaRequestBase: GCWebRequestStandard {

    let stravaAuth : OAuth2Swift
    let navigationController : UINavigationController
    
    struct Credential {
        static let serviceName = "strava"
    }

    @objc init(navigationController:UINavigationController) {
        self.navigationController = navigationController
        self.stravaAuth = OAuth2Swift(consumerKey: GCAppGlobal.credentials(forService: Credential.serviceName, andKey: "client_id"),
                                      consumerSecret: GCAppGlobal.credentials(forService: Credential.serviceName, andKey: "client_secret"),
                                      authorizeUrl: GCAppGlobal.credentials(forService: Credential.serviceName, andKey: "authenticate_url"),
                                      accessTokenUrl: GCAppGlobal.credentials(forService: Credential.serviceName, andKey: "access_token_url"),
                                      responseType: "code")
        self.stravaAuth.authorizeURLHandler = SafariURLHandler(viewController: self.navigationController, oauthSwift: self.stravaAuth)
    }
    
    init(previous : GCStravaRequestBase){
        self.navigationController = previous.navigationController
        self.stravaAuth = previous.stravaAuth
    }
    
    override func url() -> String? {
        return nil
    }
    
    func stravaUrl() -> URL? {
        return nil
    }

    override var urlDescription: String! {
        if let url = self.stravaUrl() {
            return url.path
        }else{
            return "NoUrl"
        }
    }
    
    //MARK: - Credentials
    
    @objc static func signout() {
        GCAppGlobal.profile().serviceSuccess(gcService.strava, set: false)
        self.clearCredential()
    }
    
    static func clearCredential() {
        let profile = GCAppGlobal.profile()
        profile.setLoginName("", for: gcService.strava)
        profile.setPassword("", for: gcService.strava)
    }

    func saveCredential() {
        if let jsonData = try? JSONEncoder().encode(self.stravaAuth.client.credential){
           let profile = GCAppGlobal.profile()
            profile.setLoginName(self.stravaAuth.client.credential.oauthToken, for: gcService.strava)
            profile.setPassword(String(data: jsonData, encoding: .utf8), for: gcService.strava)
            GCAppGlobal.saveSettings()
        }
    }
    
    @discardableResult
    func retrieveCredential() -> Bool {
        guard GCAppGlobal.profile().serviceSuccess(gcService.strava) else {
            return false
        }
        var rv = false
        let profile = GCAppGlobal.profile()
        if  let oauth_credential_json = profile.currentPassword(for: gcService.strava)?.data(using: .utf8),
            let credential = try? JSONDecoder().decode( OAuthSwiftCredential.self, from: oauth_credential_json ) {
            self.stravaAuth.client.credential.oauthToken = credential.oauthToken
            self.stravaAuth.client.credential.oauthTokenSecret = credential.oauthTokenSecret
            self.stravaAuth.client.credential.oauthRefreshToken = credential.oauthRefreshToken
            rv = true
        }
        return rv
    }
    
    //MARK: - Request and Authentication
    
    override func process() {
        self.retrieveCredential()
        if GCAppGlobal.profile().serviceSuccess(gcService.strava) == false {
            let urlscheme = GCAppGlobal.appURLScheme()
            self.stravaAuth.authorize(withCallbackURL: "\(urlscheme)://ro-z.net/oauth/strava",
                                      scope: "activity:read_all,read_all",
                                      state: "prod" ) { result in
                switch result {
                case .success:
                    self.saveCredential()
                    self.makeRequest()
                case .failure(let error):
                    RZSLog.error("Failed to authorise \(error)")
                    self.status = GCWebStatus.loginFailed
                    self.processDone()
                }
            }
        }else{
            self.makeRequest()
        }
    }
    
    func makeRequest() {
        if let url = self.stravaUrl() {
            self.stravaAuth.client.get(url){ result in
                switch result {
                case .success(let response):
                    self.status = GCWebStatus.OK
                    GCAppGlobal.profile().serviceSuccess(gcService.strava, set: true)
                    self.process(data: response.data)
                case .failure(let queryError):
                    switch queryError {
                    case .requestError(let underlyingError, _ /*request*/):
                        let code = (underlyingError as NSError).code
                        if code == 401 { // expired, renew
                            RZSLog.info("Renewing Strava Token")
                            self.stravaAuth.renewAccessToken(withRefreshToken: self.stravaAuth.client.credential.oauthRefreshToken) { result in
                                switch result {
                                case .success:
                                    self.saveCredential()
                                    self.makeRequest()
                                case .failure(let renewError):
                                    self.requestError(error: renewError, message: "Failed to renew token")
                                }
                            }
                        }
                        else{
                            self.requestError(error: queryError, message: "Request failed")
                        }
                    default:
                        self.requestError(error: queryError, message: "Request failed")
                    }
                }
            }
        }
    }
    
    func requestError( error : OAuthSwiftError, message : String){
        if let underlyingError = error.underlyingError {
            let code = (underlyingError as NSError).code
            let body = (underlyingError as NSError).userInfo["Response-Body"] ?? "No Body"
            RZSLog.error("\(message) \(code) \(body)")
        }else{
            RZSLog.error("\(message) \(error)")
        }
        self.status = GCWebStatus.accessDenied
        self.processDone()
    }
    
    //MARK: - to override
    
    func process(data : Data){
        self.processDone()
    }
}
