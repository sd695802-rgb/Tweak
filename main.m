#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <objc/runtime.h>

static NSString * const kMeluxNeverShowKey = @"MeluxNeverShowWelcome";

@interface MeluxWelcomeManager : NSObject <WKNavigationDelegate>
+ (void)showWelcomeDialog;
@end

@implementation MeluxWelcomeManager

#pragma mark - Show Welcome

+ (void)showWelcomeDialog {

    // إذا اختار المستخدم "عدم إظهار هذا مرة أخرى"
    if ([[NSUserDefaults standardUserDefaults]
         boolForKey:kMeluxNeverShowKey]) {
        return;
    }

    dispatch_async(dispatch_get_main_queue(), ^{

        // تحقق مرة ثانية
        if ([[NSUserDefaults standardUserDefaults]
             boolForKey:kMeluxNeverShowKey]) {
            return;
        }

        UIWindow *keyWindow = nil;

        // iOS 13+
        if (@available(iOS 13.0, *)) {

            for (UIScene *scene in
                 [UIApplication sharedApplication].connectedScenes) {

                if (scene.activationState !=
                    UISceneActivationStateForegroundActive) {
                    continue;
                }

                if (![scene isKindOfClass:[UIWindowScene class]]) {
                    continue;
                }

                UIWindowScene *windowScene =
                    (UIWindowScene *)scene;

                for (UIWindow *window in windowScene.windows) {

                    if (window.isKeyWindow) {
                        keyWindow = window;
                        break;
                    }
                }

                if (keyWindow) {
                    break;
                }
            }
        }

        // توافق مع الإصدارات القديمة
        if (!keyWindow) {
            keyWindow =
                [UIApplication sharedApplication].keyWindow;
        }

        if (!keyWindow) {
            return;
        }

        // منع ظهور نافذتين في نفس الوقت
        if ([keyWindow viewWithTag:999888]) {
            return;
        }

        UIView *overlay =
            [[UIView alloc] initWithFrame:keyWindow.bounds];

        overlay.tag = 999888;
        overlay.alpha = 0.0;

        overlay.backgroundColor =
            [UIColor colorWithRed:0.02
                            green:0.015
                             blue:0.03
                            alpha:0.88];

        CGRect webFrame = CGRectMake(
            20.0,
            (keyWindow.bounds.size.height - 500.0) / 2.0,
            keyWindow.bounds.size.width - 40.0,
            500.0
        );

        WKWebViewConfiguration *configuration =
            [[WKWebViewConfiguration alloc] init];

        WKWebView *webView =
            [[WKWebView alloc]
                initWithFrame:webFrame
                configuration:configuration];

        webView.layer.cornerRadius = 24.0;
        webView.clipsToBounds = YES;
        webView.opaque = NO;
        webView.backgroundColor =
            UIColor.clearColor;

        // Delegate
        MeluxWelcomeManager *manager =
            [[MeluxWelcomeManager alloc] init];

        webView.navigationDelegate = manager;

        // الاحتفاظ بالـ delegate
        objc_setAssociatedObject(
            webView,
            "MeluxWelcomeManager",
            manager,
            OBJC_ASSOCIATION_RETAIN_NONATOMIC
        );

        NSString *htmlContent =
        @"<!DOCTYPE html>"
        "<html lang='ar' dir='rtl'>"

        "<head>"

        "<meta charset='UTF-8'>"

        "<meta name='viewport' "
        "content='width=device-width,initial-scale=1.0'>"

        "<style>"

        "*{"
        "box-sizing:border-box;"
        "-webkit-tap-highlight-color:transparent;"
        "}"

        "html,body{"
        "margin:0;"
        "padding:0;"
        "width:100%;"
        "height:100%;"
        "}"

        "body{"
        "font-family:"
        "-apple-system,"
        "BlinkMacSystemFont,"
        "'SF Arabic',"
        "'Geeza Pro',"
        "Arial,"
        "sans-serif;"
        "background:transparent;"
        "display:flex;"
        "align-items:center;"
        "justify-content:center;"
        "color:#fff;"
        "-webkit-font-smoothing:antialiased;"
        "}"

        ".card{"
        "width:100%;"
        "max-width:340px;"
        "padding:22px;"
        "border-radius:24px;"
        "background:"
        "linear-gradient("
        "145deg,"
        "rgba(21,15,29,.99),"
        "rgba(9,7,14,.99)"
        ");"
        "border:"
        "1px solid rgba(168,85,247,.38);"
        "box-shadow:"
        "0 20px 60px rgba(0,0,0,.78);"
        "text-align:center;"
        "}"

        ".logo{"
        "display:block;"
        "width:70px;"
        "height:70px;"
        "margin:0 auto 15px;"
        "border-radius:16px;"
        "object-fit:cover;"
        "border:"
        "1px solid rgba(168,85,247,.3);"
        "}"

        ".title{"
        "font-size:24px;"
        "font-weight:800;"
        "line-height:1.4;"
        "margin:0 0 8px;"
        "}"

        ".subtitle{"
        "font-size:15px;"
        "font-weight:500;"
        "color:#cfc9d5;"
        "line-height:1.6;"
        "margin:0 0 18px;"
        "}"

        ".enter{"
        "display:block;"
        "width:100%;"
        "height:56px;"
        "border:0;"
        "border-radius:15px;"
        "background:"
        "linear-gradient(135deg,#7c3aed,#6d28d9);"
        "color:#fff;"
        "font-family:"
        "-apple-system,"
        "BlinkMacSystemFont,"
        "'SF Arabic',"
        "'Geeza Pro',"
        "Arial,"
        "sans-serif;"
        "font-size:17px;"
        "font-weight:800;"
        "margin:0 0 12px;"
        "outline:none;"
        "}"

        ".enter:active{"
        "transform:scale(.98);"
        "opacity:.88;"
        "}"

        ".link{"
        "display:flex;"
        "align-items:center;"
        "justify-content:center;"
        "width:100%;"
        "min-height:55px;"
        "padding:10px 14px;"
        "margin-top:9px;"
        "border-radius:14px;"
        "background:"
        "rgba(25,19,32,.96);"
        "border:"
        "1px solid rgba(255,255,255,.08);"
        "color:#ededed;"
        "text-decoration:none;"
        "font-family:"
        "-apple-system,"
        "BlinkMacSystemFont,"
        "'SF Arabic',"
        "'Geeza Pro',"
        "Arial,"
        "sans-serif;"
        "font-size:14px;"
        "font-weight:600;"
        "line-height:1.4;"
        "}"

        ".link:active{"
        "background:rgba(124,58,237,.18);"
        "}"

        ".dontshow{"
        "display:block;"
        "width:100%;"
        "margin-top:15px;"
        "padding:9px;"
        "border:0;"
        "background:transparent;"
        "color:#918b99;"
        "font-family:"
        "-apple-system,"
        "BlinkMacSystemFont,"
        "'SF Arabic',"
        "'Geeza Pro',"
        "Arial,"
        "sans-serif;"
        "font-size:13px;"
        "font-weight:500;"
        "}"

        ".dontshow:active{"
        "color:#c084fc;"
        "}"

        ".credit{"
        "margin-top:10px;"
        "padding-top:11px;"
        "border-top:"
        "1px solid rgba(255,255,255,.06);"
        "font-size:12px;"
        "font-weight:700;"
        "color:#c084fc;"
        "}"

        "</style>"

        "</head>"

        "<body>"

        "<div class='card'>"

        "<img class='logo' "
        "src='https://i.imgur.com/SruPOQ8.jpg'>"

        "<div class='title'>"
        "💜 مرحباً بك مجدداً"
        "</div>"

        "<div class='subtitle'>"
        "تم الكراك من قبل Melux"
        "</div>"

        "<button class='enter' "
        "onclick=\"window.location.href='app://enter'\">"
        "دخول"
        "</button>"

        "<a class='link' "
        "href='https://t.me/HRP_Harper'>"
        "👤 صاحب القناة — @HRP_Harper"
        "</a>"

        "<a class='link' "
        "href='https://t.me/oa4nq'>"
        "🛡️ مساعد الاونر — @oa4nq"
        "</a>"

        "<a class='link' "
        "href='https://t.me/harper_chat'>"
        "📢 قناة التليجرام — @harper_chat"
        "</a>"

        "<div class='credit'>"
        "تم الكراك بواسطة harper+melux"
        "</div>"

        "<button class='dontshow' "
        "onclick=\"window.location.href='app://dontshow'\">"
        "عدم إظهار هذا مرة أخرى"
        "</button>"

        "</div>"

        "</body>"

        "</html>";

        [webView
            loadHTMLString:htmlContent
            baseURL:nil];

        [overlay addSubview:webView];
        [keyWindow addSubview:overlay];

        // Animation
        [UIView animateWithDuration:0.25
                         animations:^{
            overlay.alpha = 1.0;
        }];
    });
}


#pragma mark - WebView Navigation

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:
(WKNavigationAction *)navigationAction
decisionHandler:
(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSURL *URL =
        navigationAction.request.URL;

    if (URL &&
        [URL.scheme.lowercaseString
            isEqualToString:@"app"]) {

        NSString *host =
            URL.host.lowercaseString;

        /*
         =====================================
         زر دخول
         =====================================
         
         لا نحفظ أي شيء.
         فقط يغلق شاشة الترحيب.
         
         عند تشغيل التطبيق من جديد
         ستظهر الشاشة مرة أخرى.
         */

        if ([host isEqualToString:@"enter"]) {

            [self closeWelcome:webView];

            decisionHandler(
                WKNavigationActionPolicyCancel
            );

            return;
        }


        /*
         =====================================
         عدم إظهار هذا مرة أخرى
         =====================================
         
         هذا فقط هو الذي يتم حفظه.
         */

        if ([host isEqualToString:@"dontshow"]) {

            [[NSUserDefaults standardUserDefaults]
                setBool:YES
                forKey:kMeluxNeverShowKey];

            [[NSUserDefaults standardUserDefaults]
                synchronize];

            [self closeWelcome:webView];

            decisionHandler(
                WKNavigationActionPolicyCancel
            );

            return;
        }
    }

    // روابط Telegram وغيرها
    decisionHandler(
        WKNavigationActionPolicyAllow
    );
}


#pragma mark - Close Welcome

- (void)closeWelcome:(WKWebView *)webView {

    UIView *overlay =
        webView.superview;

    if (!overlay) {
        return;
    }

    [UIView animateWithDuration:0.20
                     animations:^{
        overlay.alpha = 0.0;
    }
                     completion:^(BOOL finished) {
        [overlay removeFromSuperview];
    }];
}

@end


#pragma mark - App Launch

__attribute__((constructor))
static void MeluxInit(void) {

    dispatch_async(
        dispatch_get_main_queue(),
        ^{

            /*
             ننتظر حتى يصبح التطبيق Active
             وتصبح الـ UIWindow جاهزة.
             */

            [[NSNotificationCenter defaultCenter]
                addObserverForName:
                    UIApplicationDidBecomeActiveNotification
                object:nil
                queue:
                    [NSOperationQueue mainQueue]
                usingBlock:
                    ^(NSNotification *notification) {

                /*
                 إذا المستخدم اختار:
                 "عدم إظهار هذا مرة أخرى"
                 لا تظهر القائمة.
                 */

                if ([[NSUserDefaults standardUserDefaults]
                     boolForKey:kMeluxNeverShowKey]) {
                    return;
                }

                [MeluxWelcomeManager
                    showWelcomeDialog];
            }];
        }
    );
}
