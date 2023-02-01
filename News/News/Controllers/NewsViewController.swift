//
//  NewsViewController.swift
//  News
//
//  Created by VladVarsotski on 1.02.23.
//

import UIKit

class NewsViewController: UIViewController {
    
    var article = [Article]()
    
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
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 1000)

    }
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsDescriptionLabel)
        contentView.addSubview(newsContentLabel)
        contentView.addSubview(publishedAtLabel)
        
        
        newsImageView.frame = CGRect(x: 0,
                                     y: -30,
                                     width: contentView.frame.size.width - 0,
                                     height: 400)
        
        newsTitleLabel.frame = CGRect(x: 20,
                                      y: 170,
                                      width: contentView.frame.size.width - 60,
                                      height: 170)
        
        publishedAtLabel.frame = CGRect(x: 20,
                                        y: 330,
                                        width: contentView.frame.size.width - 60,
                                        height: 30)
        
        newsDescriptionLabel.frame = CGRect(x: 10,
                                        y: contentView.frame.size.width - 850,
                                        width: contentView.frame.size.width - 40,
                                        height: contentView.frame.size.height - 60)
        
        newsContentLabel.frame = CGRect(x: 10,
                                        y: newsImageView.frame.size.width - 220,
                                        width: contentView.frame.size.width - 40,
                                        height: contentView.frame.size.height - 0)
        
        publishedAtLabel.text = "2023.02.01 11:34"
        
        newsDescriptionLabel.text = "Сэму и Дину придется вступить в бой с полчищами кровожадных созданий, превосходящих по силе любого человека."
        
        newsContentLabel.text = "В сериале Сверхъестественное Бог выпустил всех своих созданий в мир людей. Землю заполонили всевозможные чудовища: вампиры, левиафаны, зомби и многие другие ужасные твари, жадные до человеческой крови. Молодые охотники столкнулись с серьезной проблемой: у них нет могущественного покровителя, который помог бы им разрешить трудности. Сэму и Дину придется вступить в бой с полчищами кровожадных созданий, превосходящих по силе любого человека.Героям не у кого просить помощи, поэтому они должны самостоятельно вступать в смертоносную схватку. Любая битва может закончиться мучительной гибелью, но братья готовы пожертвовать собой, чтобы спасти мир. Работы стало в разы больше, ведь теперь вся планета заполнена смертоносными тварями, которые жаждут уничтожить человечество и использовать его как источник пропитания. Хитроумным парням придется найти способ прогнать монстров без помощи всемогущего, но чрезвычайно обидчивого Бога.В сериале Сверхъестественное Бог выпустил всех своих созданий в мир людей. Землю заполонили всевозможные чудовища: вампиры, левиафаны, зомби и многие другие ужасные твари, жадные до человеческой крови. Молодые охотники столкнулись с серьезной проблемой: у них нет могущественного покровителя, который помог бы им разрешить трудности. Сэму и Дину придется вступить в бой с полчищами кровожадных созданий, превосходящих по силе любого человека.Героям не у кого просить помощи, поэтому они должны самостоятельно вступать в смертоносную схватку. Любая битва может закончиться мучительной гибелью, но братья готовы пожертвовать собой, чтобы спасти мир. Работы стало в разы больше, ведь теперь вся планета заполнена смертоносными тварями, которые жаждут уничтожить человечество и использовать его как источник пропитания. Хитроумным парням придется найти способ прогнать монстров без помощи всемогущего, но чрезвычайно обидчивого Бога."
        
        newsTitleLabel.text = "Hellosfd;lksfl;ksd;lfksd;lfksd;lfk;sdfks;ldfksd;lfkdlsfks;lkdsf;lkmmmmmmmfkmslkdmfkdsflksdfmlkkpsdfopkdsfo3095i534jofokf;"
        
    }
    
    
}
