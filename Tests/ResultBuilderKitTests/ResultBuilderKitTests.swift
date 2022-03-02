import XCTest

@testable import ResultBuilderKit

final class ResultBuilderKitTests: XCTestCase {
  func testExample() throws {
    _ = buildArray(elementType: String.self) {
      ""
    }
  }
}
