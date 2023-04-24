import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct Mhoush: Website {
  enum SectionID: String, WebsiteSectionID {
    // Add the sections that you want your website to contain here:
    case posts
    case about
  }
  
  struct ItemMetadata: WebsiteItemMetadata {
    // Add any site-specific metadata that you want to use here.
  }
  
  // Update these properties to configure your website:
  var url = URL(string: "https://mhoush.com")!
  var name = "Michael Housh"
  var description = "A description of Michael Housh"
  var language: Language { .english }
  var imagePath: Path? { nil }
  var contactInfo: [ContactInfo] = ContactInfo.allCases
}

// This will generate your website using the built-in Foundation theme:
try Mhoush().publish(withTheme: .mhoush)
