import Plot

struct ContactInfoLink: Component {
  var contactInfo: SidebarInfo

  var body: Component {
    Link(url: contactInfo.url) {
      Div {
        Icon(text: contactInfo.icon)
        Span(contactInfo.title)
          .class("social-link")
      }
      .class("l-box")
    }
  }
}
