//: Playground - noun: a place where people can play

import UIKit

import Darwin


let size = CGSize(width: 260, height: 260)
let pi:CGFloat = CGFloat(M_PI)
UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
var context = UIGraphicsGetCurrentContext()


let fullCirclePath = UIBezierPath(ovalInRect: CGRect(origin: CGPointZero, size: size))
let glucoseColor = UIColor(red: 251/255.0, green: 0, blue: 105/255.0, alpha: 1)
glucoseColor.setFill()
fullCirclePath.fill()


let start = CGFloat(-1 * M_PI_2)
var decimalInput = 0.33
let end = start + CGFloat(2 * M_PI * decimalInput)





let overlayCirclePath = UIBezierPath()
overlayCirclePath.addLineToPoint(CGPoint(x: 130, y: 30))
overlayCirclePath.addArcWithCenter(CGPoint(x: 130,y:130), radius: 100, startAngle: start, endAngle: end , clockwise: true)
overlayCirclePath.addLineToPoint(CGPoint(x: 130, y: 130))

let overlayColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
overlayColor.setFill()
overlayCirclePath.fill()

let innerCirclePath = UIBezierPath()
innerCirclePath.addArcWithCenter(CGPoint(x: 130,y:130), radius: 100, startAngle: 0, endAngle: 2 * pi , clockwise: true)
let lighter = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
lighter.setFill()
innerCirclePath.fill()



var circlePath = UIBezierPath()
circlePath.addArcWithCenter(CGPoint(x: 130,y:130), radius: 70, startAngle: 0, endAngle: 2 * pi , clockwise: true)
glucoseColor.setFill()
circlePath.fill()






let test = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()


//let circleCenter = CGPointMake(100, 100)
//
//let circleRadius = CGFloat(40)
//
//
//let testPath = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: start, endAngle: end, clockwise: true)
//testPath.addLineToPoint(circleCenter)
//UIColor.blackColor().setFill()
//testPath.fill()

