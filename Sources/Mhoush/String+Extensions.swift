import Foundation

extension String {
  var numberOfWords: Int {
    let characterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
    let components = self.components(separatedBy: characterSet)
    return components.filter { !$0.isEmpty }.count
  }

  // This is a sloppy implementation but sadly `NSAttributedString(data:options:documentAttributes:)`
  // is not available in CoreFoundation, and as such can't run on Linux (blocking CI builds).
  var withoutHtmlTags: String {
    return replacingOccurrences(of: "(?m)<pre><span></span><code>[\\s\\S]+?</code></pre>", with: "", options: .regularExpression, range: nil)
      .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
      .trimmingCharacters(in: .whitespacesAndNewlines)
  }

  /// See https://jinja2docs.readthedocs.io/en/stable/templates.html#truncate
  func truncate(length: Int = 255, killWords: Bool = false, end: String = "...", leeway: Int = 5) -> String {
    if count <= length + leeway {
      return self
    }

    if killWords {
      return prefix(length - end.count) + end
    }

    return prefix(length - end.count).split(separator: " ").dropLast().joined(separator: " ") + end
  }

  var removeBreaks: String {
    replacingOccurrences(of: "<br>", with: "")
      .replacingOccurrences(of: "<br />", with: "")
      .trimmingCharacters(in: .whitespacesAndNewlines)
  }

}
