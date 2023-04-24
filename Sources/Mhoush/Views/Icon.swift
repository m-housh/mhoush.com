import Plot

struct Icon: Component {
  let text: String

  var body: Component {
    Node<HTML.AnchorContext>
      .element(named: "i", attributes: [.class(text + " l-box social-icon")])
  }
}
