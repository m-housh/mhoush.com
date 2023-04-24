import Plot

struct SiteSidebar: Component {

  var body: Component {
    Wrapper {
      AvatarImage.mhoush
      Div {
        Icon(text: "fa-solid fa-location-dot")
        Link(url: "https://www.google.com/maps/place/Monroe,+OH/@39.4440787,-84.4055251,13z/data=!3m1!4b1!4m6!3m5!1s0x88405c1aa9731fe9:0xda2c99fae613ba40!8m2!3d39.4450552!4d-84.3610458!16zL20vMDEzamQ0") {
          Text("Monroe, OH")
        }
      }

      Div {
        H3("Social")
          .class("sidebar-header")
        LinkList(links: socalLinks)
      }
      Div {
        H3("Work")
          .class("sidebar-header")
        LinkList(links: workLinks)
      }
    }
    .class("sidebar")
  }
}

private struct LinkList: Component {
  let links: [ContactInfo]

  var body: Component {
    List(links) {
      ContactInfoLink(contactInfo: $0)
        .class("contact-link")
    }
    .class("contact-list")
  }
}

private let socalLinks: [ContactInfo] = [
  .facebook,
  .youtube
]

private let workLinks: [ContactInfo] = [
  .workPhone,
  .workEmail
]
