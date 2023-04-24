import Foundation

enum ContactInfo: String, CaseIterable {
  case email
  
  var title: String {
    switch self {
    case .email:
      return rawValue.capitalized
    }
  }
  
  var url: String {
    switch self {
    case .email:
      return "mailto:michael@mhoush.com"
    }
  }
  
  var icon: String {
    switch self {
    case .email:
      return "fa-solid fa-envelope"
    }
  }
}
