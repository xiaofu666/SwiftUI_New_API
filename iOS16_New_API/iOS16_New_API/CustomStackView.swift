//
//  CustomStackView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct CustomStackView: View {
    var body: some View {
        CustomStack {
            ForEach(1...5, id: \.self) { index in
                Circle()
                    .fill(.red)
                    .frame(width: 50, height: 50, alignment: .center)
                    .overlay {
                        Text("\(index)")
                    }
            }
        }
//        .frame(height: 300)
        .background(.gray)
    }
}

struct CustomStack: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        /*
         /// MARK: - 取子元素中的最大值 ZStack布局
         let requiredWidth = subviews.compactMap { view -> Double? in
             view.sizeThatFits(.unspecified).width
         }.max()
         let requiredHeight = subviews.compactMap { view -> Double? in
             view.sizeThatFits(.unspecified).height
         }.max()
         return .init(width: requiredWidth ?? 0, height: requiredHeight ?? 0)
         
         /// MARK: - 取子元素整体宽高  HStack布局
         let requiredWidth = subviews.compactMap { view -> Double? in
             view.sizeThatFits(.unspecified).width
         }.reduce(0, +)
         let requiredHeight = subviews.compactMap { view -> Double? in
             view.sizeThatFits(.unspecified).height
         }.max()
         return .init(width: requiredWidth, height: requiredHeight ?? 0)
         
         /// MARK: - 取子元素整体宽高  VStack布局
         let requiredWidth = subviews.compactMap { view -> Double? in
             view.sizeThatFits(.unspecified).width
         }.max()
         let requiredHeight = subviews.compactMap { view -> Double? in
             view.sizeThatFits(.unspecified).height
         }.reduce(0, +)
         return .init(width: requiredWidth ?? 0, height: requiredHeight)
         
         /// MARK: - 取子元素整体宽高  GeometryReader 布局
         return .init(width: proposal.width ?? 0, height: proposal.height ?? 0)
         
         /// MARK: - 取子元素整体宽高  自定义布局
         let requiredWidth = subviews.compactMap { view -> Double? in
             view.sizeThatFits(.unspecified).width
         }.reduce(0, +)
         let requiredHeight = subviews.compactMap { view -> Double? in
             view.sizeThatFits(.unspecified).height
         }.reduce(0, +)
         return .init(width: requiredWidth, height: requiredHeight)
         */
        
        
        let requiredWidth = subviews.compactMap { view -> Double? in
            view.sizeThatFits(.unspecified).width
        }.reduce(0, +)
        let requiredHeight = subviews.compactMap { view -> Double? in
            view.sizeThatFits(.unspecified).height
        }.reduce(0, +)
        return .init(width: requiredWidth, height: requiredHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        for subview in subviews {
            subview.place(at:origin, anchor: .topLeading, proposal: proposal)
            /*
             /// MARK: - 向右下角斜着摆放
             origin.y += subview.sizeThatFits(.unspecified).height
             origin.x += subview.sizeThatFits(.unspecified).width
             /// MARK: - 竖直向下
             origin.y += subview.sizeThatFits(.unspecified).height
             /// MARK: - 水平向右
             origin.x += subview.sizeThatFits(.unspecified).width
             //加-为反方向
             */
            origin.y += subview.sizeThatFits(.unspecified).height
            origin.x += subview.sizeThatFits(.unspecified).width
        }
    }
}
struct CustomStackView_Previews: PreviewProvider {
    static var previews: some View {
        CustomStackView()
    }
}
