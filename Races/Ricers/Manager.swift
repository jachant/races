import Foundation

class Manager {
    
    
    private init() {}
    
    private let carAraay = ["mainCar", "secondCar", "thirdCar", "fourthCar"]
    
    static let shared = Manager()
    func getCountCarArray() -> Int {
        return self.carAraay.count
    }
    func getImageForIndex(index: Int) -> String {
        return self.carAraay[index]
    }
    func saved(index: Int) {
        
        UserDefaults.standard.set(self.getImageForIndex(index: index), forKey: "car")
        
    }
    
    
}
