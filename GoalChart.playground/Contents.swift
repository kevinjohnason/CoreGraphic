//: Playground - noun: a place where people can play

import UIKit
let pi:CGFloat = CGFloat(M_PI)

func getPoint(center:CGPoint,radius:CGFloat,degree:CGFloat) -> CGPoint{
    let x:CGFloat = center.x + radius * cos(degree * pi / 180)
    let y:CGFloat = center.y + radius * sin(degree * pi / 180)
    return CGPoint(x: x, y: y)
}

let fillCircleRadius : CGFloat = 150
let centerPoint = CGPoint(x: fillCircleRadius,y:fillCircleRadius)
let size = CGSize(width: fillCircleRadius * 2, height: fillCircleRadius * 2)

let fullCirclePath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))

let activityColor = UIColor(red: 253/255.0, green: 118/255.0, blue: 0, alpha: 1)
let foodColor = UIColor(red: 138/255.0, green: 206/255.0, blue: 37/255.0, alpha: 1)
let medsColor = UIColor(red: 23/255.0, green: 194/255.0, blue: 225/255.0, alpha: 1)
let glucoseColor = UIColor(red: 251/255.0, green: 0, blue: 105/255.0, alpha: 1)

let diff : CGFloat = 32


func drawActivity(endingAngle:CGFloat, order : CGFloat,color:UIColor){
    let activityPath = UIBezierPath()
    let startAngle : CGFloat = -90
    let povotEndingAngel : CGFloat = endingAngle - 90
    let innerCircleRadius = fillCircleRadius - diff * order
    let outerCircleRadius = innerCircleRadius + diff
    activityPath.addArc(withCenter: centerPoint, radius: innerCircleRadius, startAngle: startAngle/180.0 * pi, endAngle: povotEndingAngel / 180.0 * pi, clockwise: true)
    let endingCenter = getPoint(center: centerPoint, radius: innerCircleRadius + (outerCircleRadius - innerCircleRadius) / 2, degree: povotEndingAngel)
    activityPath.addArc(withCenter: endingCenter, radius: (outerCircleRadius - innerCircleRadius) / 2, startAngle: (povotEndingAngel / 180) * pi, endAngle: (povotEndingAngel + 180) / 180 * pi, clockwise: true)
    activityPath.addArc(withCenter: centerPoint, radius: outerCircleRadius , startAngle: povotEndingAngel/180.0 * pi, endAngle: startAngle / 180.0 * pi, clockwise: false)
    let beginingCenter = getPoint(center: centerPoint, radius: innerCircleRadius + (outerCircleRadius - innerCircleRadius) / 2, degree: startAngle)
    activityPath.addArc(withCenter: beginingCenter, radius: (outerCircleRadius - innerCircleRadius) / 2, startAngle: (startAngle / 180) * pi, endAngle: (startAngle + 180) / 180 * pi, clockwise: false)
    color.setFill()
    activityPath.fill()
}



UIGraphicsBeginImageContextWithOptions(size, false, 0.0)



UIColor.black.setFill()
let backgroundPath = UIBezierPath()
backgroundPath.move(to: CGPoint(x: 0, y: 0))
backgroundPath.addLine(to: CGPoint(x: 0, y: fillCircleRadius * 2))
backgroundPath.addLine(to: CGPoint(x: fillCircleRadius * 2, y: fillCircleRadius * 2))
backgroundPath.addLine(to: CGPoint(x: fillCircleRadius * 2, y: 0))
backgroundPath.addLine(to: CGPoint(x: 0, y: 0))
backgroundPath.fill()



activityColor.setFill()
let activityBackgroundPath = UIBezierPath()
activityBackgroundPath.addArc(withCenter: centerPoint, radius: fillCircleRadius, startAngle: 0, endAngle: 2 * pi , clockwise: true)
activityBackgroundPath.fill(with: .normal, alpha: 0.3)


var boderPath = UIBezierPath()
boderPath.addArc(withCenter: centerPoint, radius: fillCircleRadius - diff + 1, startAngle: 0, endAngle: 2 * pi , clockwise: true)
UIColor.black.setFill()
boderPath.fill()


let medsPath = UIBezierPath()
medsPath.addArc(withCenter: centerPoint, radius: fillCircleRadius - diff, startAngle: 0, endAngle: 2 * pi , clockwise: true)
medsColor.setFill()
medsPath.fill(with: .normal, alpha: 0.3)

boderPath = UIBezierPath()
boderPath.addArc(withCenter: centerPoint, radius: fillCircleRadius - diff * 2 + 1, startAngle: 0, endAngle: 2 * pi , clockwise: true)
UIColor.black.setFill()
boderPath.fill()

let foodsPath = UIBezierPath()
foodsPath.addArc(withCenter: centerPoint, radius: fillCircleRadius - (diff * 2), startAngle: 0, endAngle: 2 * pi , clockwise: true)
foodColor.setFill()
foodsPath.fill(with: .normal, alpha: 0.3)

boderPath = UIBezierPath()
boderPath.addArc(withCenter: centerPoint, radius: fillCircleRadius - diff * 3 + 1, startAngle: 0, endAngle: 2 * pi , clockwise: true)
UIColor.black.setFill()
boderPath.fill()

let glucosePath = UIBezierPath()
glucosePath.addArc(withCenter: centerPoint, radius: fillCircleRadius - (diff * 3), startAngle: 0, endAngle: 2 * pi , clockwise: true)
glucoseColor.setFill()
glucosePath.fill()






drawActivity(endingAngle: 90,order:1,color:activityColor)

drawActivity(endingAngle: 120 ,order:2,color:medsColor)

drawActivity(endingAngle: 180 ,order:3,color:foodColor)

 UIGraphicsGetImageFromCurrentImageContext()
 UIGraphicsEndImageContext()




