import XCTest
import Testing

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

@Suite("ArrayBuilder Comprehensive Tests")
struct ArrayBuilderTests {

  @Test("Empty array building")
  func emptyArrayBuilding() {
    let result = buildArray(elementType: Int.self) {
      // Empty block
    }
    #expect(result.isEmpty)
    #expect(result == [])
  }

  @Test("Single element building")
  func singleElementBuilding() {
    let result = buildArray(elementType: Int.self) {
      42
    }
    #expect(result == [42])
    #expect(result.count == 1)
  }

  @Test("Multiple elements building")
  func multipleElementsBuilding() {
    let result = buildArray(elementType: Int.self) {
      1
      2
      3
      4
      5
    }
    #expect(result == [1, 2, 3, 4, 5])
    #expect(result.count == 5)
  }

  @Test("Optional element handling")
  func optionalElementHandling() {
    let optional: Int? = 10
    let nilOptional: Int? = nil

    let result = buildArray(elementType: Int.self) {
      1
      optional
      nilOptional
      2
    }
    #expect(result == [1, 10, 2])
    #expect(result.count == 3)
  }

  @Test("Collection expression handling")
  func collectionExpressionHandling() {
    let array1 = [1, 2, 3]
    let array2 = [4, 5]
    let set: Set<Int> = [6, 7]

    let result = buildArray(elementType: Int.self) {
      array1
      0
      array2
      set.sorted()
    }
    #expect(result == [1, 2, 3, 0, 4, 5, 6, 7])
  }

  @Test("Optional collection handling")
  func optionalCollectionHandling() {
    let optionalArray: [Int?] = [1, nil, 3, nil, 5]

    let result = buildArray(elementType: Int.self) {
      optionalArray
    }
    #expect(result == [1, 3, 5])
    #expect(result.count == 3)
  }

  @Test("Conditional expressions")
  func conditionalExpressions() {
    let shouldInclude = true
    let shouldExclude = false

    let result = buildArray(elementType: String.self) {
      "always"
      if shouldInclude {
        "included"
      }
      if shouldExclude {
        "excluded"
      }
      "end"
    }
    #expect(result == ["always", "included", "end"])
  }

  @Test("Switch expressions")
  func switchExpressions() {
    let value = 2

    let result = buildArray(elementType: String.self) {
      "start"
      switch value {
      case 1:
        "one"
      case 2:
        "two"
      default:
        "other"
      }
      "end"
    }
    #expect(result == ["start", "two", "end"])
  }

  @Test("Nested array building")
  func nestedArrayBuilding() {
    let result = buildArray(elementType: [Int].self) {
      buildArray(elementType: Int.self) {
        1
        2
      }
      buildArray(elementType: Int.self) {
        3
        4
        5
      }
    }
    #expect(result == [[1, 2], [3, 4, 5]])
  }

  @Test("Mixed types with common protocol")
  func mixedTypesWithCommonProtocol() {
    let result = buildArray(elementType: CustomStringConvertible.self) {
      42
      "hello"
      3.14
      true
    }
    #expect(result.count == 4)
    #expect(result.map(\.description) == ["42", "hello", "3.14", "true"])
  }

  @Test("Large array building")
  func largeArrayBuilding() {
    let result = buildArray(elementType: Int.self) {
      for i in 0..<1000 {
        i
      }
    }
    #expect(result.count == 1000)
    #expect(result == Array(0..<1000))
  }

  @Test("Complex nested conditionals")
  func complexNestedConditionals() {
    let condition1 = true
    let condition2 = false
    let value = 5

    let result = buildArray(elementType: Int.self) {
      1
      if condition1 {
        2
        if condition2 {
          3
        } else {
          4
        }
        switch value {
        case 0..<5:
          5
        case 5..<10:
          6
        default:
          7
        }
      }
      8
    }
    #expect(result == [1, 2, 4, 6, 8])
  }
}

@Suite("ArrayBuilder Performance Tests")
struct ArrayBuilderPerformanceTests {

  @Test("Performance with small arrays", .timeLimit(.minutes(1)))
  func performanceSmallArrays() {
    let iterations = 1000

    for _ in 0..<iterations {
      let _ = buildArray(elementType: Int.self) {
        1
        2
        3
        4
        5
      }
    }
  }

  @Test("Performance with medium arrays", .timeLimit(.minutes(1)))
  func performanceMediumArrays() {
    let iterations = 100

    for _ in 0..<iterations {
      let _ = buildArray(elementType: Int.self) {
        Array(0..<100)
      }
    }
  }

  @Test("Performance with large arrays", .timeLimit(.minutes(2)))
  func performanceLargeArrays() {
    let iterations = 10

    for _ in 0..<iterations {
      let _ = buildArray(elementType: Int.self) {
        Array(0..<10000)
      }
    }
  }

  @Test("Memory allocation benchmark", .timeLimit(.minutes(1)))
  func memoryAllocationBenchmark() {
    // Measure the number of array allocations
    var totalAllocations = 0

    for i in 0..<100 {
      let _ = buildArray(elementType: Int.self) {
        Array(0..<i)
        if i % 2 == 0 {
          Array(100..<(100 + i))
        }
        Array(200..<(200 + i/2))
      }
      totalAllocations += 1
    }

    #expect(totalAllocations == 100)
  }
}
