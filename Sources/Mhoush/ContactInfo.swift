import Foundation

enum ContactInfo: String, CaseIterable {
  case email
  case facebook
  case workEmail
  case workPhone
  case youtube

  var title: String {
    switch self {
    case .email:
      return rawValue.capitalized
    case .facebook:
      return rawValue.capitalized
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
    case .workEmail:
      return "fa-solid fa-envelope"
    case .workPhone:
      return "fa-solid fa-phone-volume"
    case .youtube:
      return "fa-brands fa-youtube"
    }
  }
}
