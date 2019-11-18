//
//  RevmobHelper.swift
//  TuVi
//
//  Created by Nguyen Quoc Vuong on 4/9/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit

class RevmobHelper: NSObject, RevMobAdsDelegate {
    class var share: RevmobHelper {
        struct Static {
            static let instance = RevmobHelper()
        }
        return Static.instance
    }
    fileprivate var isSessionStarted = false
    fileprivate var banner: RevMobBanner?
    fileprivate var fullscreen: RevMobFullscreen?
    
    open func initRevmob(withAppID id: String){
        let completionBlock: () -> Void = {
            self.isSessionStarted = true
        }
        let failureBlock: (Error?) -> Void = {error in
            NSLog("[RevMob Sample App] Session failed to start with error: \(error!.localizedDescription)")
        }
        RevMobAds.startSession(withAppID: id,
                                        withSuccessHandler: completionBlock,
                                        andFailHandler: failureBlock)
        
    }
    
    open func showBanner(){
        guard isSessionStarted else {
            return
        }
        
        if banner != nil {
            self.banner!.showAd()
        } else {
            //loaded first time
            banner = RevMobAds.session().banner()
            banner?.delegate = self
            let bannerLoadedHandler: (RevMobBanner?) -> Void = {revmobBanner in
                self.banner!.showAd()
            }
            let bannerFailureHandler: (RevMobBanner?, Error?) -> Void = {revmobBanner, error in
                NSLog("[RevMob Sample App] Banner failed to load with error: \(error!.localizedDescription)")
                //Banner failed    to load
            }
            let bannerOnClickHandler: (RevMobBanner?) -> Void = {revmobBanner in
                NSLog("[RevMob Sample App] Banner clicked")
            }
            banner!.load(successHandler: bannerLoadedHandler, andLoadFailHandler: bannerFailureHandler, onClickHandler: bannerOnClickHandler)
         
        
        }
        
    }
    
    
    open func loadFullscreen(){
        guard isSessionStarted else {
            return
        }
        
        fullscreen = RevMobAds.session().fullscreen()
        fullscreen!.loadAd()
    }
    
    open func showLoadedFullscreen(){
        if(fullscreen != nil) {
            fullscreen!.showAd()
        }
    }
    
    open func hideBanner() {
        if banner != nil {
            banner!.hideAd()
        }
    }
    
}
