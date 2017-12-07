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
        static let particleCreationHeight : CGFloat = 100
    }
    
    public enum WeatherType {
        case snow
        case rain
    }
    
    // ParticleView.rain()
    // ParticleView.snow()
    
    private init(originX : CGFloat, originY : CGFloat) {
        let frame = CGRect(x: originX, y: originY, width: Constants.screenWidth, height: Constants.particleCreationHeight)
        super.init(frame: frame)
        emitter = layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: bounds.size.width / 2, y: 0)
        emitter.emitterSize = bounds.size
        emitter.emitterShape = kCAEmitterLayerRectangle
        //backgroundColor = UIColor.blue
    }
    
    static func snowView() -> ParticleView {
        let view = ParticleView(originX: -150, originY: -100)
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "spark")!.cgImage
        emitterCell.birthRate = 400
        emitterCell.lifetime = 3.0
        emitterCell.color = UIColor.white.cgColor
        emitterCell.redRange = 0.0
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.0
        emitterCell.velocity = 5
        emitterCell.velocityRange = 900
        emitterCell.emissionRange = CGFloat.pi / 2
        emitterCell.emissionLongitude = -CGFloat.pi
        emitterCell.yAcceleration = 140
        emitterCell.xAcceleration = 0
        emitterCell.scale = 0.13
        emitterCell.scaleRange = -0.50
        emitterCell.scaleSpeed = 0.15
        emitterCell.alphaRange = 0.5
        emitterCell.alphaSpeed = -0.15
        view.emitter.emitterCells = [emitterCell]
        return view
    }
    
    static func rainView() -> ParticleView {
        let view = ParticleView(originX: 0, originY: -150)
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "spark")!.cgImage
        emitterCell.birthRate = 300
        emitterCell.lifetime = 3.0
        emitterCell.color = UIColor.white.cgColor
        emitterCell.redRange = 0.0
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.0
        emitterCell.velocity = 5
        emitterCell.velocityRange = 400
        emitterCell.emissionRange = 0.01
        emitterCell.emissionLatitude = .pi / 2
        emitterCell.emissionLongitude = 0
        emitterCell.yAcceleration = 150
        emitterCell.xAcceleration = 0
        emitterCell.scale = 0.10
        emitterCell.scaleRange = 0
        emitterCell.scaleSpeed = 0
        emitterCell.alphaRange = 0
        emitterCell.alphaSpeed = -0.30
        view.emitter.emitterCells = [emitterCell]
        view.transform = view.transform.scaledBy(x: 1, y: 5)
        return view
    }
    
    static func mistView() -> ParticleView {
        let view = ParticleView(originX: -300, originY: 100)
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "spark")!.cgImage
        emitterCell.birthRate = 100
        emitterCell.lifetime = 12
        emitterCell.color = UIColor.white.cgColor
        emitterCell.redRange = 0.0
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.0
        emitterCell.velocity = 30
        emitterCell.velocityRange = 25
        emitterCell.emissionRange = .pi / 6
        emitterCell.emissionLongitude = 0
        emitterCell.emissionLatitude = 0
        emitterCell.yAcceleration = 0
        emitterCell.xAcceleration = 5
        emitterCell.scale = 0.13
        emitterCell.scaleRange = -0.50
        emitterCell.scaleSpeed = 0.15
        emitterCell.alphaRange = 0.5
        emitterCell.alphaSpeed = -0.15
        view.emitter.emitterCells = [emitterCell]
        return view
    }
    
    static func cloundView() -> ParticleView {
        let view = ParticleView(originX: -120, originY: 100)
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "spark")!.cgImage
        emitterCell.birthRate = 100
        emitterCell.lifetime = 30
        emitterCell.color = UIColor.white.cgColor
        emitterCell.redRange = 0.0
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.0
        emitterCell.velocity = 25
        emitterCell.velocityRange = 30
        emitterCell.emissionRange = .pi / 6
        emitterCell.emissionLongitude = 0
        emitterCell.emissionLatitude = 0
        emitterCell.yAcceleration = 0
        emitterCell.xAcceleration = 3
        emitterCell.scale = 0.13
        emitterCell.scaleRange = -0.50
        emitterCell.scaleSpeed = 0.15
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
