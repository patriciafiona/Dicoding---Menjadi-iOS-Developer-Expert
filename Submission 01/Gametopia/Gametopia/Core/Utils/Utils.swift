//
//  Utils.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import WebKit
import SwiftUI
import UIKit

func imageCircle(imageView: UIImageView){
    imageView.layer.cornerRadius = imageView.frame.size.height / 2;
    imageView.layer.masksToBounds = true;
    imageView.layer.borderWidth = 0;
}

func viewRounded(view: AnyObject, radius: Int){
    view.layer.cornerRadius = CGFloat(radius);
    view.layer.masksToBounds = true;
    view.layer.borderWidth = 0;
}

func dateFormat(dateTxt: String)-> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let date = dateFormatter.date(from: dateTxt) else { return "" }
    
    dateFormatter.dateFormat = "MMM d, yyyy"
    return dateFormatter.string(from: date)
}

func textShadow(label: UILabel){
    label.layer.shadowColor = UIColor.black.cgColor
    label.layer.shadowRadius = 3.0
    label.layer.shadowOpacity = 1.0
    label.layer.shadowOffset = CGSize(width: 4, height: 4)
    label.layer.masksToBounds = false
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let headerString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
        
        let styles = "<font face='Arial' size='4' color= 'white'>%@"
        let text = String(format: styles, htmlContent)
        
        uiView.loadHTMLString(headerString + text, baseURL: nil)
        uiView.tintColor = UIColor.white
        
        uiView.isOpaque = false
        uiView.backgroundColor = UIColor.clear
        uiView.scrollView.backgroundColor = UIColor.clear
    }
}
