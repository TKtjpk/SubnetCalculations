import Foundation

public struct SubnetCalculations {

    public init() {
    }
    
    // MARK: Public available functions
    
    public func returnIPAsBinariesArray(ipAddress: String) -> [String] {
        var returnValue: [String] = []
        let array = ipAddress.split(separator: ".")
        array.forEach { element in
            returnValue.append(uintToEightBits(number: UInt8(element)!))
        }
        return returnValue
    }
    
    public func returnMaskAsArray(mask: Int) -> [UInt8] {
        var limit = mask
        var returnValue: [UInt8] = []
        
        for _ in 0..<4 {
            let factor = limit / 8 > 0 ? 8 : limit % 8
            returnValue.append(factor >= 1 ? uint8fromMaskCIDRNotation(factor: factor, rev: false) : 0)
            limit -= 8
        }
        return returnValue
    }
    
    public func returnMaskAsString(mask: Int) -> String {
        let array = returnMaskAsArray(mask: mask)
        return returnCIDRNotationStringFromArray(array: array)
    }
    
    public func returnMaskAsBinariesArray(mask: Int) -> [String] {
        let array = returnMaskAsArray(mask: mask)
        var returnValue: [String] = []
        array.forEach { element in
            returnValue.append(uintToEightBits(number: element))
        }
        return returnValue
    }

    public func returnWildCardAsArray(mask: Int) -> [UInt8] {
        var limit = 32 - mask
        var returnValue: [UInt8] = []
        
        for _ in 0..<4 {
            let factor = limit / 8 > 0 ? 8 : limit % 8
            returnValue.append(factor >= 1 ? uint8fromMaskCIDRNotation(factor: factor, rev: true) : 0)
            limit -= 8
        }
        return returnValue.reversed()
    }
    
    public func returnWildCardAsString(mask: Int) -> String {
        let array = returnWildCardAsArray(mask: mask)
        return returnCIDRNotationStringFromArray(array: array)
    }
    
    public func returnWildCardAsBinariesArray(mask: Int) -> [String] {
        let array = returnWildCardAsArray(mask: mask)
        var returnValue: [String] = []
        array.forEach { element in
            returnValue.append(uintToEightBits(number: element))
        }
        return returnValue
    }
    
    // MARK: Private Functions Only !!!
    
    private func returnCIDRNotationStringFromArray(array: [UInt8]) -> String {
        var returnValue = ""
        for i in 0..<4 {
            returnValue.append(String(array[i]))
            returnValue.append(i < 3 ? "." : "")
        }
        return returnValue
    }
    
    private func uintToEightBits(number: UInt8) -> String {
        let string = String(number, radix: 2)
        return repeatElement("0", count: 8 - string.count) + string
    }
    
    private func uint8fromMaskCIDRNotation(factor: Int, rev: Bool) -> UInt8 {
        let revFactor = rev ? factor : 8
        var returnValue: UInt8 = 0
        for i in 1...factor {
            returnValue += UInt8(pow(2, Double(revFactor - i)))
        }
        return returnValue
    }
}
