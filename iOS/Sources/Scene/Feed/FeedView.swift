import RxSwift
import RxCocoa
import UIKit
import SnapKit
import Then
import WebKit

class FeedView: BaseVC {
    lazy var webview: WKWebView = {
        let controller = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.userContentController = controller
        let tempWebView = WKWebView(frame: .zero, configuration: self.generateWKWebViewConfiguration())
        return tempWebView
    }()
    override func viewWillAppear(_ animated: Bool) {
        let request = URLRequest(
            url: URL(string: "https://dsm-hackathon24.netlify.app/community")!,
            cachePolicy: .returnCacheDataElseLoad
        )
        self.webview.load(request)
    }
    private func generateWKWebViewConfiguration() -> WKWebViewConfiguration {

        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences

        self.setWebCookie(cookie: [
            "accToken": Token.accessToken ?? "nil"
        ], configuration: configuration)

        return configuration
    }
    private func setWebCookie(cookie: [String: String], configuration: WKWebViewConfiguration) {
        let dataStore = WKWebsiteDataStore.nonPersistent()
        cookie.forEach {
            dataStore.httpCookieStore.setCookie(HTTPCookie(properties: [
                .domain: "dsm-hackathon24.netlify.app",
                .path: "/",
                .name: $0.key,
                .value: $0.value,
                .secure: "TRUE"
            ])!)
        }
        configuration.websiteDataStore = dataStore
    }
    override func addView() {
        view.addSubview(webview)
    }
    override func setLayout() {
        webview.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(90)
        }
    }
}
