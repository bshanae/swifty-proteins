//
//  ImageSharingService.swift
//  Swifty proteins
//
//  Created by Valeria Karon on 7/15/21.
//  Copyright © 2021 VirtualMac. All rights reserved.
//

import SwiftUI
struct ImageSharingService: UIViewControllerRepresentable {
    
    var items:[Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {

    }
}

