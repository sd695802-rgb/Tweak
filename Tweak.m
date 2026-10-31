‏#import <UIKit/UIKit.h>
‏#import <WebKit/WebKit.h>
‏@interface MeluxWelcomeManager : NSObject
‏ (void)showWelcomeDialog;
‏@end
‏@implementation MeluxWelcomeManager
‏ (void)showWelcomeDialog {
‏dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
‏UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
‏UIView *overlay = [[UIView alloc] initWithFrame:keyWindow.bounds];
‏overlay.backgroundColor = [UIColor colorWithRed:0.03 green:0.02 blue:0.05 alpha:0.85];
‏overlay.tag = 999888;
‏WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(20, (keyWindow.bounds.size.height - 480)/2, keyWindow.bounds.size.width - 40, 480)];
‏webView.layer.cornerRadius = 24.0;
‏webView.clipsToBounds = YES;
‏webView.backgroundColor = [UIColor clearColor];
‏webView.opaque = NO;
NSString *htmlContent = @"<!DOCTYPE html><html lang='ar' dir='rtl'><head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'><script src='https://cdn.tailwindcss.com'></script><link href='https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700;800&display=swap' rel='stylesheet'><style>body{font-family:'Tajawal',sans-serif;background:transparent;margin:0;display:flex;align-items:center;justify-content:center;height:100vh;}.glass-card{background:linear-gradient(135deg,rgba(20,14,28,0.98) 0%,rgba(10,7,15,0.99) 100%);backdrop-filter:blur(14px);border:1px solid rgba(168,85,247,0.4);box-shadow:0 25px 60px rgba(0,0,0,0.9);}</style></head><body><div class='glass-card w-full max-w-[340px] rounded-[24px] p-5 text-center text-white'><div class='flex flex-col items-center mb-3'><div class='w-16 h-16 rounded-xl bg-black/70 border border-purple-500/50 flex items-center justify-center overflow-hidden shadow-lg'><img src='https://i.imgur.com/SruPOQ8.jpg' alt='Logo' class='w-full h-full object-cover'></div></div><h1 class='text-lg font-bold mb-1.5 text-white'>مرحباً بك مجدداً ❤️</h1><div class='inline-block px-3 py-1 rounded-full bg-purple-500/10 border border-purple-500/30 text-purple-300 text-[11px] font-semibold mb-4'>تم الكراك من قبل Melux</div><div class='space-y-2'><button onclick='window.location.href=\"app://exit\"' class='w-full py-2.5 px-4 rounded-xl bg-gradient-to-r from-purple-700 via-violet-600 to-indigo-700 text-white font-bold text-xs shadow-lg shadow-purple-600/30 border border-purple-400/30'>دخول</button><a href='https://t.me/HRP_Harper' class='block w-full py-2.5 px-4 rounded-xl bg-gradient-to-r from-[#14101e] to-[#1e142b] border border-white/10 text-gray-200 text-xs flex justify-between items-center shadow-md'><span>👤 صاحب القناة</span><span class='text-purple-300 text-[10px] bg-purple-500/15 px-2 py-0.5 rounded-md border border-purple-500/30'>@HRP_Harper</span></a><a href='https://t.me/oa4nq' class='block w-full py-2.5 px-4 rounded-xl bg-gradient-to-r from-[#14101e] to-[#1e142b] border border-white/10 text-gray-200 text-xs flex justify-between items-center shadow-md'><span>🛡️ مساعد الاونر</span><span class='text-purple-300 text-[10px] bg-purple-500/15 px-2 py-0.5 rounded-md border border-purple-500/30'>@oa4nq</span></a><a href='https://t.me/harper_chat' class='block w-full py-2.5 px-4 rounded-xl bg-gradient-to-r from-[#14101e] to-[#1e142b] border border-white/10 text-gray-200 text-xs flex justify-between items-center shadow-md'><span>📢 قناة التيلجرام</span><span class='text-purple-300 text-[10px] bg-purple-500/15 px-2 py-0.5 rounded-md border border-purple-500/30'>@harper_chat</span></a></div><div class='mt-4 pt-2.5 border-t border-white/5 text-[11px] text-purple-300 font-semibold'>تم الكراك بواسطة Melux+harper</div></div></body></html>";
‏[webView loadHTMLString:htmlContent baseURL:nil];
‏[overlay addSubview:webView];
‏[keyWindow addSubview:overlay];
});
}
‏@end
// حقن الدالة عند بدء تشغيل التطبيق
‏%ctor {
‏[MeluxWelcomeManager showWelcomeDialog];
}
