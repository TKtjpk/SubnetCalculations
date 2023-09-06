import XCTest
@testable import SubnetCalculations

final class SubnetCalculationsTests: XCTestCase {
    let maskArr = ["0.0.0.0", "128.0.0.0", "192.0.0.0", "224.0.0.0", "240.0.0.0", "248.0.0.0", "252.0.0.0", "254.0.0.0", "255.0.0.0", "255.128.0.0", "255.192.0.0", "255.224.0.0", "255.240.0.0", "255.248.0.0", "255.252.0.0", "255.254.0.0", "255.255.0.0", "255.255.128.0", "255.255.192.0", "255.255.224.0", "255.255.240.0", "255.255.248.0", "255.255.252.0", "255.255.254.0", "255.255.255.0", "255.255.255.128", "255.255.255.192", "255.255.255.224", "255.255.255.240", "255.255.255.248", "255.255.255.252", "255.255.255.254", "255.255.255.255"]
    
    let wildCardArr = ["255.255.255.255", "127.255.255.255", "63.255.255.255", "31.255.255.255", "15.255.255.255", "7.255.255.255", "3.255.255.255", "1.255.255.255", "0.255.255.255", "0.127.255.255", "0.63.255.255", "0.31.255.255", "0.15.255.255", "0.7.255.255", "0.3.255.255", "0.1.255.255", "0.0.255.255", "0.0.127.255", "0.0.63.255", "0.0.31.255", "0.0.15.255", "0.0.7.255", "0.0.3.255", "0.0.1.255", "0.0.0.255", "0.0.0.127", "0.0.0.63", "0.0.0.31", "0.0.0.15", "0.0.0.7", "0.0.0.3", "0.0.0.1", "0.0.0.0"]
    
    var binaries: SubnetCalculations? = nil

    override func setUpWithError() throws {
        binaries = SubnetCalculations()
    }

    override func tearDownWithError() throws {
        binaries = nil
    }

    func test_IPToBinaries() throws {
        for i in 0...32 {
            let result = binaries?.returnIPAsBinariesArray(ipAddress: wildCardArr[i])
            let expected = binaries?.returnWildCardAsBinariesArray(mask: i)
            XCTAssertEqual(result, expected, "Not Equal")
        }
    }

    func test_MaskToString() throws {
        for i in 0...32 {
            let result = binaries?.returnMaskAsString(mask: i)
            let expected = maskArr[i]
            XCTAssertEqual(result, expected, "Mask doesn't match")
        }
    }
    
    func test_WildCardToString() throws {
        for i in 0...32 {
            let result = binaries?.returnWildCardAsString(mask: i)
            let expected = wildCardArr[i]
            XCTAssertEqual(result, expected, "Wild card doesn't match")
        }
    }
}
