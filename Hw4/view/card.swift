//
//  card.swift
//  Hw4
//
//  Created by david david on 06.11.2024.
//

import Foundation
import UIKit
import SnapKit
// https://www.youtube.com/watch?v=__pzeIpof1s
final class Card: UIView {
    var currentImgUrl: String?
    let catImage: UIImageView = {
        let imageView = UIImageView()
                  imageView.layer.cornerRadius = 40
                  imageView.clipsToBounds = true
                  imageView.contentMode = .scaleAspectFill
                  imageView.backgroundColor = .gray
                  return imageView
      }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupView()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupView()
       }
    private func setupView() {
        layer.cornerRadius = 10
        backgroundColor = .white
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
           
           addSubview(catImage)
           
        catImage.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(10)
               make.leading.trailing.equalToSuperview().inset(10)
               make.height.equalTo(220)
           }
       }
    
// https://www.youtube.com/watch?v=8mBexDIqkI4
    // https://medium.com/@kalidoss.shanmugam/swift-completion-handlers-an-overview-bd6e62251f1d
    // the point of using completion escaping is to notify the caller of the async function about the result.
    // Completion handlers are reqquired to sigal that some code is completed
    func loadImg(url: String, completion: @escaping () -> Void) {
        currentImgUrl = url
        if let url =  URL(string: url) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.catImage.image = image
                            completion()
                        }
                    }
                }
            }
        } else {
            self.catImage.backgroundColor = .red
            print("Invalid URL string")
            completion()
        }

    }
    func rightAnim() {
        UIView.animate(withDuration: 0.5) {
            self.catImage.transform = CGAffineTransform(translationX: -399, y: 0)
        }
        UIView.animate(withDuration: 0.5, delay: 0.5) {
            self.catImage.transform = .identity
        }
      
    }
    func leftAnim() {
        UIView.animate(withDuration: 0.5) {
            self.catImage.transform = CGAffineTransform(translationX: 399, y: 0)
        }
        UIView.animate(withDuration: 0.5, delay: 0.5) {
            self.catImage.transform = .identity
        }
      
    }
}
