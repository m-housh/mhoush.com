import Plot

struct AvatarImage: Component {
  let url: String
  let description: String

  var body: Component {
    Div {
      Image(
        url: url,
        description: description
      )
    }
    .class("avatar-image")
  }
}

extension AvatarImage {
  static let mhoush = Self.init(
    url: "https://i.ibb.co/VQMSYTP/502-E7-F3-A-374-B-4-CEB-9-E29-05-E4473505-D7-1-105-c.jpg",
    description: "michael-housh-image"
  )
}
