//
//  CanvasView.swift
//  iOS15_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct CanvasView: View {
    var body: some View {
        VStack {
            Canvas { context, size in
                
                context.draw(Text("Hello World"), at: CGPoint(x: 300, y: 450))
                
                context.draw(Image(systemName: "books.vertical"), at: CGPoint(x: 250, y: 400))
                
                context.draw(Image(systemName: "gear.circle"), in: CGRect(x: 250, y: 300, width: 100, height: 100))
                
                let path = Path { path in
                    //画矩形
                    path.addRect(CGRect(x: 220, y: 20, width: 30, height: 30))
                    //画多个矩形
                    path.addRects([CGRect(x: 320, y: 120, width: 30, height: 30),CGRect(x: 220, y: 220, width: 30, height: 30)])
                    //画圆
                    path.addEllipse(in: CGRect(x: 20, y: 20, width: 60, height: 60))
                    //画椭圆
                    path.addEllipse(in: CGRect(x: 20, y: 250, width: 160, height: 60))
                    //画圆角矩形
                    path.addRoundedRect(in: CGRect(x: 20, y: 120, width: 100, height: 100), cornerSize: CGSize(width: 30, height: 30))
                    
                    path.move(to: CGPoint(x: 100, y: 550))
                    //画相对弧（指定角度， 360为圆）
                    path.addRelativeArc(center: CGPoint(x: 100, y: 550), radius: 50, startAngle: Angle(degrees: 0), delta: Angle(degrees: 300))
                    path.addLine(to: CGPoint(x: 100, y: 550))
                    
                    //定位点
                    path.addEllipse(in: CGRect(x: 110, y: 340, width: 20, height: 20))
                    path.addEllipse(in: CGRect(x: 110, y: 440, width: 20, height: 20))
                    path.addEllipse(in: CGRect(x: 210, y: 440, width: 20, height: 20))
                    path.addEllipse(in: CGRect(x: 210, y: 340, width: 20, height: 20))
                    //画弧
                    path.move(to: CGPoint(x: 120, y: 350))
                    path.addArc(tangent1End: CGPoint(x: 120, y: 450), tangent2End: CGPoint(x: 220, y: 450), radius: 100)
                    path.addLine(to: CGPoint(x: 220, y: 350))
                    path.addLine(to: CGPoint(x: 120, y: 350))
                    
                    //画圆弧
                    path.move(to: CGPoint(x: 200, y: 550))
                    path.addArc(center: CGPoint(x: 200, y: 550), radius: 40, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 270), clockwise: true, transform: .identity)
                    path.addLine(to: CGPoint(x: 200, y: 550))
                    // 与上面做比较
                    path.move(to: CGPoint(x: 300, y: 550))
                    path.addArc(center: CGPoint(x: 300, y: 550), radius: 40, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 270), clockwise: false, transform: .identity)
                    path.addLine(to: CGPoint(x: 300, y: 550))
                    
                    //画线段
                    path.move(to: CGPoint(x: 150, y: 250))
                    path.addLine(to: CGPoint(x: 200, y: 150))
                    //画单控制点曲线
                    path.addQuadCurve(to: CGPoint(x: 150, y: 50), control: CGPoint(x: 100, y: 190))
                    //画双控制点曲线
                    path.addCurve(to: CGPoint(x: 350, y: 250), control1: CGPoint(x: 300, y: 20), control2: CGPoint(x: 140, y: 220))
                }
                
                context.stroke(path, with: .color(.red), lineWidth: 2)
                context.fill(path, with: .color(.yellow))
                
            }
        }
        .background {
            Color.green.opacity(0.3)
        }
        .navigationTitle("画布")
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
    }
}
