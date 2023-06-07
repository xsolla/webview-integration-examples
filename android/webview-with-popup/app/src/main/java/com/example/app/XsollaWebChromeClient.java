package com.example.app;

import android.content.Context;
import android.view.View;
import android.webkit.WebChromeClient;
import android.webkit.WebView;

public class XsollaWebChromeClient extends WebChromeClient {
    private final Context mContext;

    public XsollaWebChromeClient(Context context) {
        mContext = context;
    }

    @Override
    public boolean onCreateWindow(WebView view, boolean isDialog, boolean isUserGesture, android.os.Message resultMsg) {
        MainActivity mainActivity = (MainActivity) mContext;
        mainActivity.mChildWebView.setVisibility(View.VISIBLE);

        WebView.WebViewTransport transport = (WebView.WebViewTransport) resultMsg.obj;
        transport.setWebView(mainActivity.mChildWebView);
        resultMsg.sendToTarget();
        return true;
    }

    @Override
    public void onCloseWindow(WebView window) {
        if (window != null && window instanceof XsollaChildWebView) {
            window.setVisibility(View.GONE);
        }
    }
}
