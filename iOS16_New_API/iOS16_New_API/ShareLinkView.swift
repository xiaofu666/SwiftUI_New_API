//
//  ShareLinkView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct ShareLinkView: View {
    var body: some View {
        VStack(spacing: 25) {
            
            ShareLink(item: URL(string: "https://baidu.com")!) {
                Text("Share URL")
            }
            
            ShareLink(item: "Hello Message") {
                Text("Share Message")
            }
            
            let Pic = ImageFile(image: Image("Pic"))
            ShareLink(item: Pic, preview: SharePreview("图片", image: Pic.image)) {
                Text("Share Image")
            }
        }
    }
}

struct ImageFile: Transferable {
    var image: Image
    
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }
}

struct ShareLinkView_Previews: PreviewProvider {
    static var previews: some View {
        ShareLinkView()
    }
}
