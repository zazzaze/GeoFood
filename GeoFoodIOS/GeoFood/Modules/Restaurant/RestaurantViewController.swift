//
//  RestaurantViewController.swift
//  GeoFood
//
//  Created by Егор on 17.03.2021.
//

import UIKit

/// Выходные методы контроллера
protocol RestaurantViewControllerOutput: AnyObject {
    func viewDidLoad()
}

/// Контроллер кафе
class RestaurantViewController: UIViewController {
    
    /// Взаимодействует ли пользователь с скроллом
    var isDragging = false
    /// Скроллится ли скролл
    var isDecelerating = false
    /// Последняя позиция контента скролла
    var lastSalesTableScrollY: CGFloat = 0
    
    /// Презентер кафе
    var presenter: RestaurantViewControllerOutput!
    
    /// Верхняя вью с информацией о кафе
    private let header = RestaurantHeaderView()
    /// Таблица общих акций
    private let salesTable = UITableView()
    /// Коллекция специальных акций
    private let specialSalesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    /// Точки под коллекцией с указанием текущей акции
    private let pageControl = UIPageControl()
    /// Общий скролл
    private let scrollView = UIScrollView()
    /// Контент скролла
    private let contentView = UIView()
    
    /// id ячейки коллекции
    private let collectionCellIdentifier = "stockCell"
    
    /// Модель данных ресторана
    private var viewModel: RestaurantViewModel?
    /// Верхний констреинт таблицы общих акций
    private var salesTableTopAnchor: NSLayoutYAxisAnchor?
    
    /// Перерисовать вью
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = contentView.bounds.size
    }
    
    /// Контроллер загрузился
    override func viewDidLoad() {
        view.backgroundColor = .white
        title = "Акции"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let background = UIImage(named: "background")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        configureSubviews()
        addAllSubviews()
        initConstraints()
        presenter.viewDidLoad()
    }
    
    /// Конфигурация отображения внутренних вью
    func configureSubviews() {
        header.translatesAutoresizingMaskIntoConstraints = false
        salesTable.translatesAutoresizingMaskIntoConstraints = false
        salesTable.delegate = self
        salesTable.dataSource = self
        salesTable.register(SaleCell.self, forCellReuseIdentifier: collectionCellIdentifier)
        salesTable.backgroundColor = .clear
        salesTable.separatorStyle = .none
        salesTable.allowsSelection = false
        salesTable.isScrollEnabled = false
        salesTable.showsVerticalScrollIndicator = false
        salesTableTopAnchor = salesTable.topAnchor

        specialSalesCollection.backgroundColor = .clear
        specialSalesCollection.translatesAutoresizingMaskIntoConstraints = false
        specialSalesCollection.dataSource = self
        specialSalesCollection.register(SpecialSaleCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        specialSalesCollection.showsHorizontalScrollIndicator = false
        specialSalesCollection.isPagingEnabled = true
        specialSalesCollection.layer.masksToBounds = false
        let layout = specialSalesCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.frame.width - 60, height: 160)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.minimumLineSpacing = 60
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.isUserInteractionEnabled = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.masksToBounds = true
    }
    
    /// Добавить все вью в контроллер
    func addAllSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(header)
        contentView.addSubview(specialSalesCollection)
        contentView.addSubview(salesTable)
        contentView.addSubview(pageControl)
    }
    
    /// Активировать констреинты
    func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            header.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33),
            header.heightAnchor.constraint(equalToConstant: 60),

            specialSalesCollection.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            specialSalesCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            specialSalesCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            specialSalesCollection.heightAnchor.constraint(equalToConstant: 160),

            pageControl.topAnchor.constraint(equalTo: specialSalesCollection.bottomAnchor, constant: 5),
            pageControl.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 10),
            pageControl.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),

            salesTable.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            salesTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            salesTable.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            salesTable.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            salesTable.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: salesTable.bottomAnchor)
        ])
        scrollView.contentSize = contentView.bounds.size
    }
}

extension RestaurantViewController: RestaurantPresenterOutput {
    /// Сконфигурировать вью по модели данных кафе
    /// - Parameter vm: Модель данных кафе
    func configure(with vm: RestaurantViewModel) {
        self.viewModel = vm
        header.configure(with: vm)
        specialSalesCollection.isHidden = vm.specialSales.count == 0
        pageControl.isHidden = vm.specialSales.count == 0
        if specialSalesCollection.isHidden {
            salesTable.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10).isActive = true
        } else {
            salesTable.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10).isActive = true
        }
        salesTable.reloadData()
        specialSalesCollection.reloadData()
    }
}

extension RestaurantViewController: UITableViewDataSource {
    /// Создание ячейки для таблицы
    /// - Parameters:
    ///   - tableView: Таблица, для которой создается ячейка
    ///   - indexPath: Номер ячейки
    /// - Returns: Ячейка с данными
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: collectionCellIdentifier) as? SaleCell,
              let viewModel = self.viewModel else {
            return UITableViewCell()
        }
        let sale = viewModel.sales[indexPath.row]
        cell.configure(with: sale)
        return cell
    }
    
    /// Количество ячеек
    /// - Parameters:
    ///   - tableView: Таблица, для которой определяется количество ячеек
    ///   - section: Секция, в которой будут ячейки
    /// - Returns: Число ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sales.count ?? 0
    }
    
    /// Вычисление высоты для ячейки таблицы
    /// - Parameters:
    ///   - tableView: Таблица, для которой определяется высота ячейки
    ///   - indexPath: Индекс ячейки
    /// - Returns: Высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

extension RestaurantViewController: UITableViewDelegate {
    
    /// Создание вью с заголовком для таблицы
    /// - Parameters:
    ///   - tableView: Таблица
    ///   - section: Секция таблицы
    /// - Returns: Вью с заголовком
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        let label = UILabel(frame: CGRect(x: 3, y: 0, width: view.frame.width - 3, height: 30))
        label.text = "Все акции:"
        label.textColor = UIColor(named: "dark_blue")
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        view.addSubview(label)
        view.backgroundColor = .clear
        return view
    }
    
    /// Высота вью с заголовком
    /// - Parameters:
    ///   - tableView: Таблица
    ///   - section: Секция таблицы
    /// - Returns: Высота
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
}

extension RestaurantViewController: UICollectionViewDataSource {
    /// Вычисление количества ячеек в коллекции
    /// - Parameters:
    ///   - collectionView: Коллекция
    ///   - section: Секция коллекции
    /// - Returns: Количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = viewModel?.specialSales.count ?? 0
        return viewModel?.specialSales.count ?? 0
    }
    
    /// Конфигурация ячейки для коллекции
    /// - Parameters:
    ///   - collectionView: Коллекция
    ///   - indexPath: Индекс коллекции
    /// - Returns: Ячейка коллекции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? SpecialSaleCollectionViewCell,
              let viewModel = self.viewModel
        else {
            return UICollectionViewCell()
        }
        
        let sale = viewModel.specialSales[indexPath.row]
        cell.configure(with: sale)
        return cell
    }
    
}


extension RestaurantViewController: UIScrollViewDelegate {
    
    /// Индекс отображаемой ячейки коллекции
    func getCurrentPage() {
        let visibleRect = CGRect(origin: specialSalesCollection.contentOffset, size: specialSalesCollection.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = specialSalesCollection.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
    
    /// Событие завершения скролла
    /// - Parameters:
    ///   - scrollView: Скролл
    ///   - decelerate: Будет ли пролистывание дальше
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.scrollView && !isDecelerating {
            if scrollView.contentOffset.y > 20  {
                scrollView.setContentOffset(CGPoint(x: 0, y: salesTable.frame.minY), animated: true)
                scrollView.isScrollEnabled = false
                self.salesTable.isScrollEnabled = true
                self.isModalInPresentation = true
                isDragging = true
            } else {
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
        if scrollView == salesTable {
            if scrollView.contentOffset.y <= 0 && lastSalesTableScrollY <= 0 {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                self.scrollView.isScrollEnabled = true
                scrollView.isScrollEnabled = false
                self.isModalInPresentation = false
            }
            lastSalesTableScrollY = scrollView.contentOffset.y
        }
    }
    
    /// Скролл завершил пролистывание
    /// - Parameter scrollView: Скролл
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView && !isDragging {
            if scrollView.contentOffset.y > 20  {
                scrollView.setContentOffset(CGPoint(x: 0, y: salesTable.frame.minY), animated: true)
                scrollView.isScrollEnabled = false
                self.salesTable.isScrollEnabled = true
                self.isModalInPresentation = true
                isDecelerating = true
            } else {
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
        if scrollView == salesTable {
            if scrollView.contentOffset.y <= 0 && lastSalesTableScrollY <= 0 {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                self.scrollView.isScrollEnabled = true
                scrollView.isScrollEnabled = false
                self.isModalInPresentation = false
                isDragging = false
                isDecelerating = false
            }
            lastSalesTableScrollY = scrollView.contentOffset.y
        }
        if scrollView == specialSalesCollection {
            getCurrentPage()
        }
    }
    
    /// Скролл скролится пользователем
    /// - Parameter scrollView: Скролл
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == specialSalesCollection {
            getCurrentPage()
        }
    }
    
    /// Скролл закончил касание пользователя
    /// - Parameters:
    ///   - scrollView: Скролл
    ///   - velocity: Разница при скроле
    ///   - targetContentOffset: Текущая точка
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == specialSalesCollection {
            getCurrentPage()
        }
    }
}
