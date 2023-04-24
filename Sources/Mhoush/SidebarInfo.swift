import Foundation

enum SidebarInfo: String, CaseIterable {
  case email
  case facebook
  case github
  case linkedin
  case location
  case work
  case workEmail
  case workPhone
  case youtube


  var title: String {
    switch self {
    case .email:
      return rawValue.capitalized
    case .facebook:
      return rawValue.capitalized
    case .github:
      return "GitHub"
    case .linkedin:
      return "LinkedIn"
    case .location:
      return "Monroe, OH"
    case .work:
      return "Housh Home Energy"
    case .workEmail:
      return "Email"
    case .workPhone:
      return "Phone"
    case .youtube:
      return "YouTube"
    }
  }
  
  var url: String {
    switch self {
    case .email:
      return "mailto:michael@mhoush.com"
    case .facebook:
      return "https://www.facebook.com/michael.housh"
    case .github:
      return "https://github.com/m-housh"
    case .linkedin:
      return "https://www.linkedin.com/in/michael-housh-714746271/"
    case .location:
      return "https://www.google.com/maps/place/Monroe,+OH/@39.4440787,-84.4055251,13z/data=!3m1!4b1!4m6!3m5!1s0x88405c1aa9731fe9:0xda2c99fae613ba40!8m2!3d39.4450552!4d-84.3610458!16zL20vMDEzamQ0"
    case .work:
      return "https://www.houshhomeenergy.com"
    case .workEmail:
      return "mailto:mhoush@houshhomeenergy.com"
    case .workPhone:
      return "tel:5137936374"
    case .youtube:
      return "https://www.youtube.com/channel/UCb58SeURd5bObfTiL0KoliA"
    }
  }
  
  var icon: String {
    switch self {
    case .email:
      return "fa-solid fa-envelope"
    case .facebook:
      return "fa-brands fa-square-facebook"
    case .github:
      return "fa-brands fa-square-github"
    case .linkedin:
      return "fa-brands fa-linkedin"
    case .location:
      return "fa-solid fa-location-dot"
    case .work:
      return "fa-solid fa-building"
    case .workEmail:
      return "fa-solid fa-envelope"
    case .workPhone:
      return "fa-solid fa-phone-volume"
    case .youtube:
      return "fa-brands fa-youtube"
    }
  }
}

extension Array where Element == SidebarInfo {

  static let personal: Self = [
    .location, .email
  ]

  static let social: Self = [
    .facebook, .youtube, .github, .linkedin
  ]

  static let work: Self = [
    .work, .workEmail, .workPhone
  ]
}
