import Plot

struct SiteSidebar: Component {

  var body: Component {
    Wrapper {
      AvatarImage.mhoush
      Div {
        LinkList(links: .personal)
      }

      Div {
        H3("Follow Me")
          .class("sidebar-header")
        LinkList(links: .social)
      }
      Div {
        H3("Work")
          .class("sidebar-header")
        LinkList(links: .work)
      }
    }
    .class("sidebar")
  }
}

private struct LinkList: Component {
  let links: [SidebarInfo]

  var body: Component {
    List(links) {
      ContactInfoLink(contactInfo: $0)
        .class("contact-link")
    }
    .class("contact-list")
  }
}
