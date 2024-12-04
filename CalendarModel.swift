import Foundation

class CalendarModel {
    
    private func getDaysArray(date: Date) -> [Date] {
        var daysArray = [Date]()
        
        for day in -10...10 {
            let day = date.getDateWithOffset(byDays: day)
            daysArray.append(day)
        }
        return daysArray
    }
    public func getWeekForCalendar(date: Date) -> [DateModel] {
        let dayArray = getDaysArray(date: date)
        let dateModelsArray = dayArray.map { $0.convertDateToModel() }
        return dateModelsArray
    }
}
