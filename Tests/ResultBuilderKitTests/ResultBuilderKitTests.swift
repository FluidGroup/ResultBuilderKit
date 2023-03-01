import XCTest

@testable import ResultBuilderKit

final class ResultBuilderKitTests: XCTestCase {
  func testExample() throws {
    _ = buildArray(elementType: String.self) {
      ""
    }
    
    _ = buildArray(elementType: String.self) {
      switch 1 {
      case 1:
        ""
      default:
        ""
      }
    }
  }
}
