import UIKit

class MonthLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(alignment: NSTextAlignment) {
        self.init()
        textAlignment = alignment
        
        configure()
    }
    private func configure() {
        textColor = .gray
        text = "November"
        translatesAutoresizingMaskIntoConstraints = false
    }
}
