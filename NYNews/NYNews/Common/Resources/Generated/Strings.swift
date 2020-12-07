// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Alert {
    internal enum Action {
      /// OK
      internal static let ok = L10n.tr("Localizable", "alert.action.ok")
    }
    internal enum Message {
      internal enum Error {
        /// An unknow error occured, Please try again later!
        internal static let generic = L10n.tr("Localizable", "alert.message.error.generic")
        /// No news to display, Please try again later!
        internal static let noData = L10n.tr("Localizable", "alert.message.error.noData")
      }
    }
    internal enum Title {
      /// Error
      internal static let error = L10n.tr("Localizable", "alert.title.error")
    }
  }

  internal enum NewsDetail {
    /// %i Views
    internal static func nbViews(_ p1: Int) -> String {
      return L10n.tr("Localizable", "newsDetail.nbViews", p1)
    }
    /// News Detail
    internal static let pageTitle = L10n.tr("Localizable", "newsDetail.pageTitle")
  }

  internal enum NyNews {
    /// NY News
    internal static let pageTitle = L10n.tr("Localizable", "nyNews.pageTitle")
    /// Refreshing News...
    internal static let refreshMessage = L10n.tr("Localizable", "nyNews.refreshMessage")
    internal enum ActionSheet {
      internal enum Action {
        /// 1 Day
        internal static let oneDay = L10n.tr("Localizable", "nyNews.actionSheet.action.oneDay")
        /// 1 Month
        internal static let oneMonth = L10n.tr("Localizable", "nyNews.actionSheet.action.oneMonth")
        /// 1 Week
        internal static let oneWeek = L10n.tr("Localizable", "nyNews.actionSheet.action.oneWeek")
      }
      internal enum Title {
        /// News Period
        internal static let newsPeriod = L10n.tr("Localizable", "nyNews.actionSheet.title.newsPeriod")
      }
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
