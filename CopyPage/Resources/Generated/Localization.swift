// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Webnavigationview {
    /// Maak je dossier compleet
    /// door stap voor stap je
    /// data te verzamelen
    /// bij onderstaande bronnen
    public static let subtitle = L10n.tr("Localizable", "webnavigationview.subtitle")
    /// Gegevens verzamelen
    public static let title = L10n.tr("Localizable", "webnavigationview.title")
    public enum Prompt {
      /// Start
      public static let button = L10n.tr("Localizable", "webnavigationview.prompt.button")
      /// je verzameld hier
      /// de volgende gegevens:
      /// 
      /// - BRP gegevens
      /// - Inkomens gegevens
      /// - ID gegevens
      public static let description = L10n.tr("Localizable", "webnavigationview.prompt.description")
      /// MijnOverheid
      public static let headline = L10n.tr("Localizable", "webnavigationview.prompt.headline")
      /// Gegevens verzamelen bij
      public static let title = L10n.tr("Localizable", "webnavigationview.prompt.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
