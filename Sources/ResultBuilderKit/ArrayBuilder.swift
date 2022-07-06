
public func buildArray<T>(elementType: T.Type? = nil, @ArrayBuilder<T> _ build: () -> [T]) -> [T] {
  build()
}

@resultBuilder
public struct ArrayBuilder<Element> {

  public static func buildBlock() -> [Element] {
    []
  }

  public static func buildBlock<C: Collection>(_ contents: C...) -> [Element] where C.Element == Element {
    return contents.flatMap { $0 }
  }

  public static func buildOptional(_ component: [Element]?) -> [Element] {
    return component ?? []
  }

  public static func buildEither(first component: [Element]) -> [Element] {
    return component
  }

  public static func buildEither(second component: [Element]) -> [Element] {
    return component
  }
  
  public static func buildArray(_ components: [[Element]]) -> [Element] {
    components.flatMap { $0 }
  }

  public static func buildExpression(_ element: Element?) -> [Element] {
    return element.map { [$0] } ?? []
  }

  public static func buildExpression(_ element: Element) -> [Element] {
    return [element]
  }

  public static func buildExpression<C: Collection>(_ elements: C) -> [Element] where C.Element == Element {
    Array(elements)
  }

  public static func buildExpression<C: Collection>(_ elements: C) -> [Element] where C.Element == Optional<Element> {
    elements.compactMap { $0 }
  }

}
