import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    private let dayOffWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "Mon"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOffDayLabel: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var isToday: Bool = false {
        didSet {
            backgroundColor = isToday ? .green : .gray
            dayOffWeekLabel.textColor = .white
            numberOffDayLabel.textColor = .white
        }
    }
    
    static let idCalendarCell = "idCalendarCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 10
        backgroundColor = .gray
        
        addSubview(dayOffWeekLabel)
        addSubview(numberOffDayLabel)
    }
    
    public func configure(_ model: DateModel, isToday: Bool) {
        dayOffWeekLabel.text = model.dayOfWeek
        numberOffDayLabel.text = model.numberOfDay
        self.isToday = isToday
    }
}

extension CalendarCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayOffWeekLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dayOffWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            numberOffDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            numberOffDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
