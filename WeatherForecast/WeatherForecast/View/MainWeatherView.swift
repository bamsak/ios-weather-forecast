//
//  MainWeatherView.swift
//  WeatherForecast
//
//  Created by BOMBSGIE on 2023/12/08.
//

import UIKit

final class MainWeatherView: UIView {
    private weak var delegate: (MainWeatherViewDelegate & AlertPresentable)?

    init(delegate: (MainWeatherViewDelegate & AlertPresentable)?) {
        self.delegate = delegate
        super.init(frame: .zero)
        collectionViewConfigure()
        backgroudImageConfigure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "backgroundImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.headerMode = .supplementary
            configuration.backgroundColor = .clear
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.15))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            let section = NSCollectionLayoutSection.list(using: configuration,
                                                         layoutEnvironment: layoutEnvironment)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(WeeklyWeatherCell.self, forCellWithReuseIdentifier: WeeklyWeatherCell.reuseIdentifier)
        collectionView.register(CurrentHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CurrentHeaderView.reuseIdentifier)
        delegate?.setRefreshControl(with: collectionView)
        
        return collectionView
    }()
    
    private func collectionViewConfigure() {
        addSubview(collectionView)
        
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
    
    private func backgroudImageConfigure() {
        insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension MainWeatherView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellCount = delegate?.getCellCount() else {
            return 0
        }
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyWeatherCell.reuseIdentifier, for: indexPath) as? WeeklyWeatherCell else {
            return WeeklyWeatherCell()
        }
        
        delegate?.updateCell(cell, at: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentHeaderView.reuseIdentifier, for: indexPath) as? CurrentHeaderView else {
            return CurrentHeaderView()
        }
        headerView.delegate = delegate
        delegate?.updateHeaderView(headerView, collectionView: collectionView)
        
        return headerView
    }
}

extension MainWeatherView {
    func updateUI() {
        collectionView.reloadData()
    }
}
