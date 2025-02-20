import Foundation
import Saga

extension Date {
  func formatted(_ format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
}

extension Item where M == ArticleMetadata {
  var summary: String {
    if let summary = metadata.summary {
      return summary
    }
    return String(body.withoutHtmlTags.truncate())
  }

  var imagePath: String {
    let image = metadata.image ?? "\(filenameWithoutExtension).png"
    return "/articles/images/\(image)"
  }
}
