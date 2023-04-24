import Plot

extension Node where Context == HTML.AnchorContext {
  static func icon(_ text: String) -> Node {
    .element(named: "i", attributes: [.class(text + " l-box social-icon")])
  }
}
