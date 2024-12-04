import UIKit

class ViewController: UIViewController {
    
    @objc private let prevWeekButton = CalendarMoveButton(imageName: "chevron.backward")
    @objc private let nextWeekButton = CalendarMoveButton(imageName: "chevron.forward")
    private let calendarCollectionView = CalendarCollectionView()
    private let prevMonthLabel = MonthLabel()
    private let nextMonthLabel = MonthLabel(alignment: .right)

    
    private let calendarModel = CalendarModel()
    
    private var centerDate = Date()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        calendarCollectionView.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstrains()
    }
    private func setupViews() {
        view.backgroundColor = .white
        
        updateData(day: 0)
        calendarCollectionView.calendarDelegate = self
        view.addSubview(calendarCollectionView)
        
        prevWeekButton.addTarget(self, action: #selector(prevWeekButtonTapped), for: .touchUpInside)
        nextWeekButton.addTarget(self, action: #selector(nextWeekButtonTapped), for: .touchUpInside)
        
        view.addSubview(prevWeekButton)
        view.addSubview(nextWeekButton)
        view.addSubview(prevMonthLabel)
        view.addSubview(nextMonthLabel)
    }
    @objc private func prevWeekButtonTapped() {
        calendarCollectionView.scrollToItem(at: [0, 3], at: .centeredHorizontally, animated: true)
    }
    @objc private func nextWeekButtonTapped() {
        calendarCollectionView.scrollToItem(at: [0, 17], at: .centeredHorizontally, animated: true)
    }
    private func updateData(day offset: Int) {
        centerDate = centerDate.getDateWithOffset(byDays: offset)
        let daysArray = calendarModel.getWeekForCalendar(date: centerDate)
        
        calendarCollectionView.setDaysArray(daysArray)
        calendarCollectionView.reloadData()
        calendarCollectionView.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
        
        prevMonthLabel.text = daysArray[7].monthName
        nextMonthLabel.text = daysArray[13].monthName
        
    }
}
    //MARK: - CalendarProtocol
    
    extension ViewController: CalendarProtocol {
        
        func maxOffsetLeft() {
            updateData(day: -7)
    }
        func maxOffsetRight() {
            updateData(day: 7)
        }
    }

extension ViewController {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            prevWeekButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            prevWeekButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            prevWeekButton.heightAnchor.constraint(equalToConstant: 60),
            prevWeekButton.widthAnchor.constraint(equalToConstant: 40),

            nextWeekButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nextWeekButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nextWeekButton.heightAnchor.constraint(equalToConstant: 60),
            nextWeekButton.widthAnchor.constraint(equalToConstant: 40),
            
            calendarCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            calendarCollectionView.leadingAnchor.constraint(equalTo: prevWeekButton.trailingAnchor, constant: 5),
            calendarCollectionView.trailingAnchor.constraint(equalTo: nextWeekButton.leadingAnchor, constant: -5),
            calendarCollectionView.heightAnchor.constraint(equalToConstant: 60),
            
            prevMonthLabel.topAnchor.constraint(equalTo: nextWeekButton.bottomAnchor, constant: 5),
            prevMonthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            nextMonthLabel.topAnchor.constraint(equalTo: nextWeekButton.bottomAnchor, constant: 5),
            nextMonthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
}
