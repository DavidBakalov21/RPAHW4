import Foundation
import UIKit
import SnapKit

final class ImgCell: UITableViewCell {
   
    // https://stackoverflow.com/questions/41475501/creating-a-shadow-for-a-uiimageview-that-has-rounded-corners
    let imageContainer: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 10
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 40).cgPath
        return view
    }()
    // https://developer.apple.com/documentation/swift/array/randomelement()
    let catImage: UIImageView = {
        let imageView = UIImageView()
                  imageView.layer.cornerRadius = 40
                  imageView.clipsToBounds = true
                  imageView.contentMode = .scaleAspectFill
                  imageView.backgroundColor = .gray
                  return imageView
      }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        setupView()
        setupLayout()
        }
    init() {
        super.init(style: .default, reuseIdentifier: "imgCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        imageContainer.snp.makeConstraints {
            
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(90)
            $0.height.equalTo(90)
            
        }
        catImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
        }

    func setupView() {
        backgroundColor = .white
        addSubview(imageContainer)
        imageContainer.addSubview(catImage)
    }
    
    func setupCell(with imgUrl: String) {
        if let url =  URL(string: imgUrl) {
                DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self?.catImage.image = image
                            }
                        }
                    }
                }
            } else {
                self.catImage.backgroundColor = .red
                print("Invalid URL string")
            }
      
    }
    
}
