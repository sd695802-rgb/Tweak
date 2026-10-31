#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface MeluxWelcomeManager : NSObject
+ (void)showWelcomeDialog;
@end

@implementation MeluxWelcomeManager

+ (void)showWelcomeDialog {
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),
        dispatch_get_main_queue(),
        ^{
            UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;

            if (!keyWindow) {
                return;
            }

            UIView *overlay = [[UIView alloc] initWithFrame:keyWindow.bounds];
            overlay.backgroundColor =
                [UIColor colorWithRed:0.03
                                green:0.02
                                 blue:0.05
                                alpha:0.85];
            overlay.tag = 999888;

            WKWebView *webView =
                [[WKWebView alloc] initWithFrame:CGRectMake(
                    20,
                    (keyWindow.bounds.size.height - 480) / 2,
                    keyWindow.bounds.size.width - 40,
                    480
                )];

            webView.layer.cornerRadius = 24.0;
            webView.clipsToBounds = YES;
            webView.backgroundColor = [UIColor clearColor];
            webView.opaque = NO;

            NSString *htmlContent =
            @"<!DOCTYPE html>"
            "<html lang='ar' dir='rtl'>"
            "<head>"
            "<meta charset='UTF-8'>"
            "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
            "<style>"
            "body{"
            "font-family:Arial,sans-serif;"
            "background:transparent;"
            "margin:0;"
            "display:flex;"
            "align-items:center;"
            "justify-content:center;"
            "height:100vh;"
            "}"
            ".card{"
            "background:linear-gradient(135deg,rgba(20,14,28,.98),rgba(10,7,15,.99));"
            "border:1px solid rgba(168,85,247,.4);"
            "border-radius:24px;"
            "padding:20px;"
            "text-align:center;"
            "color:white;"
            "width:100%;"
            "max-width:340px;"
            "box-sizing:border-box;"
            "}"
            ".logo{"
            "width:64px;"
            "height:64px;"
            "border-radius:12px;"
            "margin:auto;"
            "object-fit:cover;"
            "}"
            "button,a{"
            "display:block;"
            "width:100%;"
            "box-sizing:border-box;"
            "margin-top:10px;"
            "padding:12px;"
            "border-radius:12px;"
            "text-decoration:none;"
            "}"
            "button{"
            "border:0;"
            "background:#7c3aed;"
            "color:white;"
            "font-weight:bold;"
            "}"
            "a{"
            "background:#18121f;"
            "border:1px solid rgba(255,255,255,.1);"
            "color:#ddd;"
            "}"
            "</style>"
            "</head>"
            "<body>"
            "<div class='card'>"
            "<img class='logo' src='https://i.imgur.com/SruPOQ8.jpg'>"
            "<h2>مرحباً بك مجدداً 💜</h2>"
            "<p>تم الكراك من قبل Melux</p>"
            "<button onclick='window.location.href=\"app://exit\"'>دخول</button>"
            "<a href='https://t.me/HRP_Harper'>👤 صاحب القناة — @HRP_Harper</a>"
            "<a href='https://t.me/oa4nq'>🛡️ مساعد الاونر — @oa4nq</a>"
            "<a href='https://t.me/harper_chat'>📢 قناة التيلجرام — @harper_chat</a>"
            "<p>تم الكراك بواسطة Melux + harper</p>"
            "</div>"
            "</body>"
            "</html>";

            [webView loadHTMLString:htmlContent baseURL:nil];

            [overlay addSubview:webView];
            [keyWindow addSubview:overlay];
        }
    );
}

@end

__attribute__((constructor))
static void init(void) {
    [MeluxWelcomeManager showWelcomeDialog];
}
