//
//  WeeklyWeatherCell.swift
//  WeatherForecast
//
//  Created by 김수경 on 2023/12/08.
//

import UIKit

final class WeeklyWeatherCell: UICollectionViewCell, ReuseIdentifiable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private  lazy var containerView: UIView = {
        let view = UIView()
        
        view.addSubview(dateLabel)
        view.addSubview(labelImageStack)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var labelImageStack: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(weatherImageView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private func configure() {
        contentView.addSubview(containerView)
    
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            labelImageStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            labelImageStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            weatherImageView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height),
            weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor)
        ])
    }
    
    func updateUI(date: String, temperature: String, image: UIImage?) {
        dateLabel.text = date
        temperatureLabel.text = temperature
        weatherImageView.image = image
    }
}
