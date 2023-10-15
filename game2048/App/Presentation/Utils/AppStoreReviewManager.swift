//


import Foundation
import StoreKit

 
enum AppStoreReviewManager {
    
    
    static func requestReviewIfAppropriate() {
        
        
        if #available(iOS 14.0, *) {
            guard let scene = UIApplication
                .shared
                .connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
            
            SKStoreReviewController.requestReview(in: scene)
            
        } else {
          SKStoreReviewController.requestReview()
        }
    }
}
