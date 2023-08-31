package com.example.app;

import android.os.Message;
import android.view.ViewGroup;
import android.webkit.WebChromeClient;
import android.webkit.WebView;

public class XsollaWebChromeClient extends WebChromeClient {
    @Override
    public boolean onCreateWindow(WebView view, boolean isDialog, boolean isUserGesture, Message resultMsg) {
        WebView newWebView = new WebView(view.getContext());

        newWebView.setWebViewClient(new XsollaWebViewClient());
        newWebView.getSettings().setJavaScriptEnabled(true);
        newWebView.getSettings().setSupportMultipleWindows(true);
        newWebView.getSettings().setJavaScriptCanOpenWindowsAutomatically(true);

        view.addView(newWebView);

        WebView.WebViewTransport transport = (WebView.WebViewTransport) resultMsg.obj;
        transport.setWebView(newWebView);
        resultMsg.sendToTarget();

        return true;
    }

    @Override
    public void onCloseWindow(WebView window) {
        if (window != null && window.getParent() != null) {
            ((ViewGroup) window.getParent()).removeView(window);
        }
    }
}
