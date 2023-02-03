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
        scrollView.backgroundColor = .systemBackground
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .systemBackground
        contentView.frame = view.bounds
        contentView.frame.size = contentSize
        return contentView
    }()
    
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
    
    private let dividerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "divider")
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
        scrollView.addSubview(contentView)
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsDescriptionLabel)
        contentView.addSubview(newsContentLabel)
        contentView.addSubview(publishedAtLabel)
        contentView.addSubview(moredetailedButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(dividerImageView)
        
        //        Add Target Button
        moredetailedButton.addTarget(self,
                                     action: #selector(moredetailedButtonTapped),
                                     for: .touchUpInside)
        
        shareButton.addTarget(self,
                              action: #selector(shareButtonTapped),
                              for: .touchUpInside)
        
        
        
        setupConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                
        
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
extension NewsViewController {
    
    private func setupConstraints() {
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let leftImageConstraint = NSLayoutConstraint(item: newsImageView,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                                     toItem: self.contentView,
                                                     attribute: .left,
                                                     multiplier: 1,
                                                     constant: 0)
        let rightImageConstraint = NSLayoutConstraint(item: newsImageView,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: self.contentView,
                                                     attribute: .right,
                                                     multiplier: 1,
                                                     constant: 0)
        let topImageConstraint = NSLayoutConstraint(item: newsImageView,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: self.contentView,
                                                    attribute: .top,
                                                    multiplier: 1,
                                                    constant: -40)
        let heightImageConstraint = NSLayoutConstraint(item: newsImageView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: 350)

        
        NSLayoutConstraint.activate([leftImageConstraint,rightImageConstraint,topImageConstraint,heightImageConstraint])
        
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftTitleLabel = NSLayoutConstraint(item: newsTitleLabel,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                           toItem: self.contentView,
                                                     attribute: .left,
                                                     multiplier: 1,
                                                     constant: 16)
        let rightTitleLabel = NSLayoutConstraint(item: newsTitleLabel,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: self.newsImageView,
                                                     attribute: .right,
                                                     multiplier: 1,
                                                     constant: -16)
        let bottomTitleLabel = NSLayoutConstraint(item: newsTitleLabel,
                                               attribute: .bottom,
                                               relatedBy: .equal,
                                               toItem: self.newsImageView,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: -70)
        
        NSLayoutConstraint.activate([leftTitleLabel, rightTitleLabel,bottomTitleLabel])
        
        publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftpublishedAtLabel = NSLayoutConstraint(item: publishedAtLabel,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                           toItem: self.newsImageView,
                                                     attribute: .left,
                                                     multiplier: 1,
                                                     constant: 16)
        let rightpublishedAtLabel = NSLayoutConstraint(item: publishedAtLabel,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: self.newsImageView,
                                                     attribute: .right,
                                                     multiplier: 1,
                                                     constant: -16)
        let bottompublishedAtLabel = NSLayoutConstraint(item: publishedAtLabel,
                                               attribute: .bottom,
                                               relatedBy: .equal,
                                               toItem: self.newsImageView,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: -30)
        
        NSLayoutConstraint.activate([leftpublishedAtLabel, rightpublishedAtLabel,bottompublishedAtLabel])
        
        newsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftDescriptionLabel = NSLayoutConstraint(item: newsDescriptionLabel,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                           toItem: self.contentView,
                                                     attribute: .left,
                                                     multiplier: 1,
                                                     constant: 16)
        let rightDescriptionLabel = NSLayoutConstraint(item: newsDescriptionLabel,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: self.newsImageView,
                                                     attribute: .right,
                                                     multiplier: 1,
                                                     constant: -16)
        let topDescriptionLabel = NSLayoutConstraint(item: newsDescriptionLabel,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.newsImageView,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 20)
        
        NSLayoutConstraint.activate([leftDescriptionLabel, rightDescriptionLabel,topDescriptionLabel])
        
        dividerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let leftdividerConstraint = NSLayoutConstraint(item: dividerImageView,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                                     toItem: self.contentView,
                                                     attribute: .left,
                                                     multiplier: 1,
                                                     constant: 10)
        let rightdividerConstraint = NSLayoutConstraint(item: dividerImageView,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: self.contentView,
                                                     attribute: .right,
                                                     multiplier: 1,
                                                     constant: -10)
        let topdividerConstraint = NSLayoutConstraint(item: dividerImageView,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: self.newsDescriptionLabel,
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: 10)
        
        NSLayoutConstraint.activate([leftdividerConstraint, rightdividerConstraint,topdividerConstraint])

        
        newsContentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftContentLabel = NSLayoutConstraint(item: newsContentLabel,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                           toItem: self.contentView,
                                                     attribute: .left,
                                                     multiplier: 1,
                                                     constant: 16)
        let rightContentLabel = NSLayoutConstraint(item: newsContentLabel,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: self.newsImageView,
                                                     attribute: .right,
                                                     multiplier: 1,
                                                     constant: -16)
        let topContentLabel = NSLayoutConstraint(item: newsContentLabel,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.newsDescriptionLabel,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 30)
        
        NSLayoutConstraint.activate([leftContentLabel, rightContentLabel,topContentLabel])
        
        moredetailedButton.translatesAutoresizingMaskIntoConstraints = false
        
        let leftmoredetailedButton = NSLayoutConstraint(item: moredetailedButton,
                                            attribute: .left,
                                            relatedBy: .equal,
                                            toItem: self.contentView,
                                            attribute: .left,
                                            multiplier: 1,
                                            constant: 50)
        let rightmoredetailedButton = NSLayoutConstraint(item: moredetailedButton,
                                             attribute: .right,
                                             relatedBy: .equal,
                                             toItem: self.contentView,
                                             attribute: .right,
                                             multiplier: 1,
                                             constant: -50)
        let bottommoredetailedButton = NSLayoutConstraint(item: moredetailedButton,
                                           attribute: .bottom,
                                           relatedBy: .equal,
                                           toItem: self.shareButton,
                                           attribute: .top,
                                           multiplier: 1,
                                           constant: -20)
        let heightmoredetailedButton = NSLayoutConstraint(item: moredetailedButton,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: 50)
        
        
        NSLayoutConstraint.activate([leftmoredetailedButton, rightmoredetailedButton, bottommoredetailedButton,heightmoredetailedButton])
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        let leftshareButton = NSLayoutConstraint(item: shareButton,
                                            attribute: .left,
                                            relatedBy: .equal,
                                            toItem: self.contentView,
                                            attribute: .left,
                                            multiplier: 1,
                                            constant: 50)
        let rightshareButton = NSLayoutConstraint(item: shareButton,
                                             attribute: .right,
                                             relatedBy: .equal,
                                             toItem: self.contentView,
                                             attribute: .right,
                                             multiplier: 1,
                                             constant: -50)
        let bottomshareButton = NSLayoutConstraint(item: shareButton,
                                           attribute: .bottom,
                                           relatedBy: .equal,
                                           toItem: self.contentView,
                                           attribute: .bottom,
                                           multiplier: 1,
                                           constant: -20)
        let heightshareButton = NSLayoutConstraint(item: shareButton,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: 50)
        
        
        NSLayoutConstraint.activate([leftshareButton, rightshareButton, bottomshareButton,heightshareButton])
    }
}

