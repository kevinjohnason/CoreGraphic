//
//  MovieSpotIconView.swift
//  MovieSpot
//
//  Created by Kevin Minority on 1/5/16.
//  Copyright © 2016 Nazca Traingle. All rights reserved.
//

import UIKit
protocol SplashProtocol{
    func animationFinished()
}

@IBDesignable
class MovieSpotIconView:UIView{
    override init(frame:CGRect){
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForInterfaceBuilder()
    {
        super.prepareForInterfaceBuilder()
        setCircleLayer()
    }
    
    var delegate:SplashProtocol?
    
    @IBInspectable var radius : CGFloat = 50 {
        didSet{
            self.layer.sublayers?.removeAll()
            self.layer.mask?.sublayers?.removeAll()
            //self.setCircleLayer()
        }
    }
    
    let animationUnit : Double = 0.25
    
    var innerCircleRadius :CGFloat {
        return radius/3.5
    }
    
    var innerCircleSurrandingRadius:CGFloat{
        return radius / 1.7
    }
    var centerCircleRadius : CGFloat{
        return radius/5
    }
    var layerCenter : CGPoint {
        return center
    }
    var anchorHeight :CGFloat{
        return radius/3.8
    }
    var circleSubLayer : CAShapeLayer!
    var anchorLayer : CAShapeLayer!
    var subCirclesLayers : [CAShapeLayer] = []
    let circleColor = UIColor(red: 86/255, green: 183/255, blue: 164/255, alpha: 0.95)
    let pi = CGFloat(M_PI)
    
    var rect:CGRect{
        get{
            return CGRect(x: layerCenter.x - radius, y: layerCenter.y - radius, width: radius * 2, height: radius * 2)
        }
    }
    
    private func getCircleRect(layerCenter:CGPoint,radius:CGFloat) -> CGRect{
        return CGRect(x: layerCenter.x - radius, y: layerCenter.y - radius, width: radius * 2, height: radius * 2)
    }
    private func getCircleLayer(layerCenter:CGPoint,radius:CGFloat) -> CAShapeLayer{
        let layer = CAShapeLayer()
        let r = getCircleRect(layerCenter, radius: radius)
        layer.path =
            UIBezierPath(ovalInRect: r).CGPath
        return layer
    }
    
    private func getCircleLayerWithDegree(fromPoint:CGPoint,fromRadius:CGFloat, degree:CGFloat,toRadius:CGFloat) -> CAShapeLayer{
        let newCenterX = radius + sin(degree * pi / 180)*(fromRadius)
        let newCenterY = radius + cos(degree * pi / 180)*(fromRadius)
        return getCircleLayer(CGPoint(x: newCenterX, y: newCenterY), radius: toRadius)
    }
    private func getPointFromDegree(degree:CGFloat) -> CGPoint{
        let newCenterX = layerCenter.x + sin(degree * pi / 180)*(radius)
        let newCenterY = layerCenter.y + cos(degree * pi / 180)*(radius)
        return CGPoint(x: newCenterX, y: newCenterY)
    }
    
    internal func setCircleLayer(){
        self.layer.backgroundColor = circleColor.CGColor
        self.layer.mask = getCircleLayer(layerCenter, radius: radius)
        print("x:\(self.center.x) y:\(self.center.y)")
        
        addSmallCenterLayer()
        addSubCircleLayers()
    }
    
    private func addSmallCenterLayer(){
        let centerLayer = getCircleLayer(layerCenter,radius:centerCircleRadius)
        centerLayer.fillColor = UIColor.whiteColor().CGColor
        self.layer.addSublayer(centerLayer)
    }
    
    private func addSubCircleLayers(){
        var index=0
        circleSubLayer = CAShapeLayer()
        circleSubLayer.frame = CGRectMake(layerCenter.x-radius, layerCenter.y-radius, radius * 2, radius * 2)
        for var i:CGFloat=180 ; i > -180 ; i = i - 72 {
            let layer = getCircleLayerWithDegree(layerCenter, fromRadius: innerCircleSurrandingRadius , degree: i, toRadius: innerCircleRadius)
            layer.fillColor = UIColor.whiteColor().CGColor
            layer.opacity = 0
            circleSubLayer.addSublayer(layer)
            subCirclesLayers.append(layer)
            index += 1
        }
        self.layer.addSublayer(circleSubLayer)
    }
    
    func startAnimation(){
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.toValue = 1
        animation.fromValue = 0
        animation.duration = animationUnit
        animation.setValue("subCircle", forKey: "type")
        animation.delegate = self
        for i in 0..<subCirclesLayers.count{
            animation.beginTime = animationUnit + CACurrentMediaTime() + Double(i)*2/10
            animation.setValue(subCirclesLayers[i], forKey: "layer")
            animation.setValue(i, forKey: "index")
            subCirclesLayers[i].addAnimation(animation, forKey: nil)
        }
    }
    
    private func startToTurn(){
        let rotate = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotate.values = [0.0, M_PI, M_PI * 2, M_PI * 3, M_PI * 4, M_PI * 5]
        rotate.keyTimes = [0.0, animationUnit, animationUnit * 2, animationUnit * 3,animationUnit * 4, animationUnit * 5]
        rotate.additive = true
        rotate.duration = animationUnit * 5
        rotate.repeatCount = 1
        rotate.delegate = self
        rotate.setValue("turnCircles", forKey: "type")
        circleSubLayer.addAnimation(rotate, forKey: "test")
        addAnchorLayer()
    }
    
    
    private func addAnchorLayer(){
        anchorLayer = CAShapeLayer()
        let fromAnchorPath = UIBezierPath()
        fromAnchorPath.moveToPoint(CGPoint(x: layerCenter.x + radius, y: layerCenter.y))
        fromAnchorPath.addLineToPoint(CGPoint(x: layerCenter.x + radius, y: layerCenter.y + 10))
        fromAnchorPath.addLineToPoint(getPointFromDegree(80))
        anchorLayer.path = fromAnchorPath.CGPath
        self.layer.mask?.addSublayer(anchorLayer)
        let anchorAnimation = CABasicAnimation(keyPath: "path")
        anchorAnimation.duration = animationUnit * 5
        let toAnchorPath = UIBezierPath()
        toAnchorPath.moveToPoint(CGPoint(x: layerCenter.x + radius, y: layerCenter.y))
        toAnchorPath.addLineToPoint(CGPoint(x: layerCenter.x + radius, y: layerCenter.y + radius  + anchorHeight))
        toAnchorPath.addLineToPoint(getPointFromDegree(39))
        anchorAnimation.toValue = toAnchorPath.CGPath
        anchorAnimation.setValue(toAnchorPath, forKey: "path")
        anchorAnimation.setValue(anchorLayer, forKey: "layer")
        anchorAnimation.setValue("anchor", forKey: "type")
        anchorAnimation.delegate=self
        anchorAnimation.removedOnCompletion = false
        anchorAnimation.fillMode =  kCAFillModeForwards
        anchorLayer.addAnimation(anchorAnimation, forKey: "nil")
    }
    
    
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let type = anim.valueForKey("type") as? String{
            if type == "subCircle"{
                let layer = anim.valueForKey("layer") as! CAShapeLayer
                layer.opacity = 1
                if let index = anim.valueForKey("index") as? Int{
                    if index == subCirclesLayers.count-1{
                        startToTurn()
                    }
                }
            }
            else if type == "anchor"{
                self.anchorLayer.path = (anim.valueForKey("path") as? UIBezierPath)?.CGPath
                delegate?.animationFinished()
            }
        }
    }
}