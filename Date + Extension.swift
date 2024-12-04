import Foundation

extension Date {
    private func createDateFormatter(format: String, locale: String = "en_EN") -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.dateFormat = format
        return formatter
    }
    
    func getDateWithOffset(byDays offset: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: offset, to: self) ?? Date()
    }
    
    func convertDateToModel() -> DateModel {
        let calendar = Calendar.current
        
        let numberOfDay = calendar.component(.day, from: self)
        let dayOfWeek = createDateFormatter(format: "EEEEEE").string(from: self)
        let monthName = getMonthFromDate()
        let dateString = createDateFormatter(format: "yyyy-MM-dd").string(from: self)
        
        return DateModel(numberOfDay: String(numberOfDay),
                         dayOfWeek: dayOfWeek,
                         monthName: monthName,
                         dateString: dateString)
    }
    
    func getMonthFromDate(using formatter: DateFormatter? = nil) -> String {
        let dateFormatter = formatter ?? createDateFormatter(format: "MMMM")
        return dateFormatter.string(from: self)
    }
    
    func formattedDate(style: String) -> String {
        return createDateFormatter(format: style).string(from: self)
    }

    func dateFormatddMMyyyy() -> String {
        return createDateFormatter(format: "yyyy-MM-dd").string(from: self)
    }
}
