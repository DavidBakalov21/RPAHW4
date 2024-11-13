//
//  spinner.swift
//  Hw4
//
//  Created by david david on 06.11.2024.
//

import Foundation
import SnapKit
import UIKit

final class Spinner: UIView {

    var spinner: UIImageView = {
        let imageView = UIImageView()
        // https://www.hackingwithswift.com/example-code/uikit/how-to-use-system-icons-in-your-app
        imageView.image = UIImage(systemName: "arrow.2.circlepath", withConfiguration:
                                    UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))
        imageView.tintColor = .red
        return imageView
    }()
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupView()
        animateSpinner()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupView()
           animateSpinner()
       }
    var spinnerAngle: CGFloat = 0
    private func setupView() {
        addSubview(spinner)
           
        spinner.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
           }
       }
    // https://medium.com/@nirajpaul.ios/uiview-lifecycle-12435f8de492
    // https://developer.apple.com/documentation/uikit/uiview/1622563-willmove
    // called when view is about to be added or removed, we need it
    // to continue the animation after returning from other screen
    override func willMove(toWindow newWindow: UIWindow?) {
            super.willMove(toWindow: newWindow)
        if newWindow != nil {
            animateSpinner()
        }
    }
    func animateSpinner() {

   // https://stackoverflow.com/questions/31478630/animate-rotation-uiimageview-in-swift
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
               rotation.toValue = NSNumber(value: Double.pi * 2)
               rotation.duration = 1
               rotation.isCumulative = true
               rotation.repeatCount = Float.greatestFiniteMagnitude
               spinner.layer.add(rotation, forKey: "rotationAnimation")
        
        }

}
