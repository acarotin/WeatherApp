//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/24/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation
import UIKit

class BackgroundView: UIView {
    
    init(main: String?) {
        
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = UIColor.gray
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = bounds
        blurredEffectView.alpha = 0.7;
        self.insertSubview(blurredEffectView, at: 1)
        
        /*if (main != nil) {
            if main == "Rain" {
                let particleView = ParticleView.rainView()
                self.insertSubview(particleView, at: 0)
            } else {
                let particleView = ParticleView.snowView()
                self.insertSubview(particleView, at: 0)
            }
        } else {
            let particleView = ParticleView.snowView()
            self.insertSubview(particleView, at: 0)
        }*/
        
        let particleView = ParticleView.mistView()
        self.insertSubview(particleView, at: 0)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    
    }
}
