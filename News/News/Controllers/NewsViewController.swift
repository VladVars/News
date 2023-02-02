//
//  NewsViewController.swift
//  News
//
//  Created by VladVarsotski on 1.02.23.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
    var urlString = String()
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.backgroundColor = .systemBackground
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    //    private lazy var contentView: UIView = {
    //        let contentView = UIView()
    //        contentView.backgroundColor = .systemBackground
    //        contentView.frame.size = contentSize
    //        return contentView
    //    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 100)
        
    }
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let newsContentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private let moredetailedButton: UIButton = {
        let button = UIButton()
        button.setTitle("More Detailed", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(newsImageView)
        scrollView.addSubview(newsTitleLabel)
        scrollView.addSubview(newsDescriptionLabel)
        scrollView.addSubview(newsContentLabel)
        scrollView.addSubview(publishedAtLabel)
        scrollView.addSubview(moredetailedButton)
        scrollView.addSubview(shareButton)
        
//        Add Target Button
        moredetailedButton.addTarget(self,
                              action: #selector(moredetailedButtonTapped),
                              for: .touchUpInside)
        
        shareButton.addTarget(self,
                              action: #selector(shareButtonTapped),
                              for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        newsImageView.frame = CGRect(x: 0,
                                     y: -30,
                                     width: scrollView.frame.size.width - 0,
                                     height: 400)
        
        newsTitleLabel.frame = CGRect(x: 20,
                                      y: 170,
                                      width: scrollView.frame.size.width - 60,
                                      height: 170)
        
        publishedAtLabel.frame = CGRect(x: 20,
                                        y: 330,
                                        width: scrollView.frame.size.width - 60,
                                        height: 30)
        
        newsDescriptionLabel.frame = CGRect(x: 10,
                                            y: 80,
                                            width: scrollView.frame.size.width - 40,
                                            height: scrollView.frame.size.height - 100)
        
        newsContentLabel.frame = CGRect(x: 10,
                                        y: 200,
                                        width: scrollView.frame.size.width - 40,
                                        height: scrollView.frame.size.height - 0)
        
        moredetailedButton.frame = CGRect(x: 30,
                                          y: 750,
                                          width: scrollView.frame.size.width - 80,
                                          height: 50)
        
        shareButton.frame = CGRect(x: 30,
                                   y: 830,
                                   width: scrollView.frame.size.width - 80,
                                   height: 50)
    }
    
    @objc private func moredetailedButtonTapped() {
        
        guard let url = URL(string: urlString) else { return}
        
        let vc = SFSafariViewController(url: url)
        
        present(vc, animated: true)
    }
    
    @objc private func shareButtonTapped() {
        let shaerVC = UIActivityViewController(activityItems: [urlString], applicationActivities: nil)
        shaerVC.popoverPresentationController?.sourceView = view
        
        present(shaerVC, animated: true)
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        newsDescriptionLabel.text = viewModel.description
        publishedAtLabel.text = viewModel.publishedAt
        newsContentLabel.text = viewModel.content
        
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    
}
