//
//  game2048App.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency

@main
struct game2048App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
                }
        }
    }
    
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
        }
    }
}


struct GoogleAdView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        let bannerSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
        let banner = GADBannerView(adSize: bannerSize)
        banner.rootViewController = viewController
        viewController.view.addSubview(banner)
        viewController.view.frame = CGRect(origin: .zero, size: bannerSize.size)
        
        banner.adUnitID = "ca-app-pub-2621096690952385/1577372838"
//        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.load(GADRequest())
        
        return viewController
    }

    func updateUIViewController(_ viewController: UIViewController, context: Context) {
        
    }
}

