import Plot

extension Node where Context == HTML.DocumentContext {
  
  static func head(for site: Mhoush) -> Node {
    Node.head(
      .title(site.name),
      .meta(
        .charset(.utf8),
        .name("viewport"),
        .content("width=device-width, initial-scale=1")
      ),
      .link(
        .rel(.stylesheet),
        .href("/MyTheme/styles.css")
      ),
      .script(
        .src("https://kit.fontawesome.com/bc8a6d16c5.js"),
        .attribute(named: "crossorigin", value: "anonymous")
      )
    )
  }
  
}
