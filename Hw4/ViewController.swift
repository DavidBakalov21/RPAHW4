import UIKit
import Combine
class ViewController: UIViewController {
    let card: Card = {
        let card = Card()
        card.accessibilityIdentifier = "card"
        return card
    }()

    let catFetcher = CatAPIService()
    let spinner: Spinner = {
        let spinner = Spinner()
        spinner.accessibilityIdentifier = "spinner" 
        return spinner
    }()
    var cancellable = Set<AnyCancellable>()
    let buttonLike: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.circle", withConfiguration:
                                    UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)), for: .normal)
        button.tintColor = .systemGreen
        button.accessibilityIdentifier = "buttonLike"
        return button
    }()
    let buttonDislike: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle", withConfiguration:
                                    UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)), for: .normal)
        button.tintColor = .systemRed
        button.accessibilityIdentifier = "buttonDislike"
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(card)
        view.addSubview(buttonLike)
        view.addSubview(buttonDislike)
        view.addSubview(spinner)
        view.bringSubviewToFront(spinner)
        fetchImg()
        card.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(300)
        }
        buttonLike.snp.makeConstraints {
            $0.trailing.equalTo(card.snp.centerX)
            $0.top.equalTo(card.snp.bottom).offset(5)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
        buttonDislike.snp.makeConstraints {
            $0.leading.equalTo(card.snp.centerX).offset(10)
            $0.top.equalTo(card.snp.bottom).offset(5)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
        spinner.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(100)
            
        }
        // https://www.youtube.com/watch?v=OTBnam8WWZs
        buttonLike.addTarget(self, action: #selector(likeFunc), for: .touchUpInside)
        buttonDislike.addTarget(self, action: #selector(dislikeFunc), for: .touchUpInside)
        
            // https://www.youtube.com/watch?v=JVYqnDriRJ0
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(lefty))
           swipeRight.direction = .right
           card.addGestureRecognizer(swipeRight)
           
           let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(righty))
           swipeLeft.direction = .left
           card.addGestureRecognizer(swipeLeft)
      
    }
   
    @objc func likeFunc() {
        print("Like")
    }
    @objc func dislikeFunc() {
        print("Dislike")
    }
    @objc func lefty() {
        print("Dislike")
        card.leftAnim()
        card.catImage.image=nil
        fetchImg()
    }
    @objc func righty() {
        print("Like")
        card.rightAnim()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let url = card.currentImgUrl {
                appDelegate.liked.append(url)
            }
        }
        card.catImage.image=nil
        fetchImg()
    }
    func fetchImg() {
        print("ssdv")
        self.spinner.alpha = 1.0
        catFetcher.fetchCats()
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error fetching cats:", error)
                }
            } receiveValue: { cats in
                for cat in cats {
                    print(cat.url)
                    // here we can see that when completion executes we hide spinner
                    self.card.loadImg(url: cat.url) { 
                        DispatchQueue.main.async {
                            self.spinner.alpha = 0.0
                        }
                    }
                }

            }
            .store(in: &cancellable)
    }
  
}
