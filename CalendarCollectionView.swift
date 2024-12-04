import UIKit

protocol CalendarProtocol: AnyObject {
    func maxOffsetLeft()
    func maxOffsetRight()
}

class CalendarCollectionView: UICollectionView {
    
    weak var calendarDelegate: CalendarProtocol?
    
    private var daysArray = [DateModel]()
    
    private let collectionLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        
        setupLayout()
        configure()
        setDelegates()
        register(CalendarCollectionViewCell.self,
                 forCellWithReuseIdentifier: CalendarCollectionViewCell.idCalendarCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        collectionLayout.minimumLineSpacing = 3
        collectionLayout.scrollDirection = .horizontal
    }
    
    private func configure() {
        backgroundColor = .none
        bounces = false
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        delegate = self
        dataSource = self
    }
    
    public func setDaysArray(_ array: [DateModel]) {
        daysArray = array
        reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x < 3 {
            calendarDelegate?.maxOffsetLeft()
        }
        if scrollView.contentOffset.x > self.frame.width * 2 {
            calendarDelegate?.maxOffsetRight()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CalendarCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarCollectionViewCell.idCalendarCell,
            for: indexPath
        ) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let dateModel = daysArray[indexPath.row]
        
        let isToday = dateModel.dateString == Date().dateFormatddMMyyyy()
        
        cell.configure(dateModel, isToday: isToday)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CalendarCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped cell at index \(indexPath.row)")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarCollectionView: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 7.5,
                      height: collectionView.frame.height)
    }
}
