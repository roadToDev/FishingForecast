import Foundation

struct DateManager {
    
    func getMonthBy(string: String) -> String{
        
        let date = getDateBy(string: string)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "MMMM"
        let nameOfMonth = dateFormatter.string(from: date!)
        return nameOfMonth
    }
    
    func getMonthBy(date: Date) -> Int {
        
        let calendar = Calendar.current
        return calendar.component(.month, from: date)
        
    }
    
    func format(fromDate: String) -> String{
        let date = fromDate.replacingOccurrences(of: "-", with: ".")
        var start = date.index(date.startIndex, offsetBy: 5)
        let end = date.index(date.startIndex, offsetBy: 7)
        let month = String(date[start..<end])
        start = date.index(date.startIndex, offsetBy: 8)
        let day = String(date[start...])
        
        return day + "." + month
    }
    
    func getDateBy(string: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: string)
        
        return date
    }
    
}
