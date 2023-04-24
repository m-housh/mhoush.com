import Plot

struct SiteFooter: Component {
  var body: Component {
    Footer {
      Div {
        Paragraph {
          Text("Generated using ")
          Link("Publish", url: "https://github.com/johnsundell/publish")
        }
        Paragraph {
          Link("RSS feed", url: "/feed.rss")
        }
      }
      .class("footer")
    }
  }
}
