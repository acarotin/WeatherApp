//
//  ParticleView.swift
//  WeatherApp
//
//  Created by Axel CAROTINE on 11/24/17.
//  Copyright © 2017 Axel CAROTINE. All rights reserved.
//

import Foundation
import UIKit

class ParticleView: UIView {
    
    var emitter: CAEmitterLayer!
    
    private enum Constants {
        static let screenWidth = UIScreen.main.bounds.width
        //static let screenHeight = UIScreen.main.bounds.height
        static let particleCreationHeight : CGFloat = 30
    }
    
    public enum WeatherType {
        case snow
        case rain
    }
    
    // ParticleView.rain()
    // ParticleView.snow()
    
    private init() {
        let frame = CGRect(x: -150, y: -100, width: Constants.screenWidth, height: Constants.particleCreationHeight)
        super.init(frame: frame)
        emitter = layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: bounds.size.width / 2, y: 0)
        emitter.emitterSize = bounds.size
        emitter.emitterShape = kCAEmitterLayerRectangle
        //backgroundColor = UIColor.blue
    }
    
    static func rainView() -> ParticleView {
        let view = ParticleView()
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "spark")!.cgImage
        emitterCell.birthRate = 150
        emitterCell.lifetime = 8.0
        emitterCell.color = UIColor.white.cgColor
        emitterCell.redRange = 0.0
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.0
        emitterCell.velocity = 5
        emitterCell.velocityRange = 350
        emitterCell.emissionRange = CGFloat.pi / 2
        emitterCell.emissionLongitude = -CGFloat.pi
        emitterCell.yAcceleration = 20
        emitterCell.xAcceleration = 0
        emitterCell.scale = 0.13
        emitterCell.scaleRange = 0.05 
        emitterCell.scaleSpeed = -0.25
        emitterCell.alphaRange = 0.5
        emitterCell.alphaSpeed = -0.15
        view.emitter.emitterCells = [emitterCell]
        return view
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
}
