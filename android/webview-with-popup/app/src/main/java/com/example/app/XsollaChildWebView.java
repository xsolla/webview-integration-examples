package com.example.app;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.AttributeSet;
import android.webkit.WebSettings;
import android.webkit.WebView;

public class XsollaChildWebView extends WebView {

    @SuppressLint("SetJavaScriptEnabled")
    public XsollaChildWebView(Context context, AttributeSet attrs) {
        super(context, attrs);

        WebSettings webSettings = getSettings();
        webSettings.setJavaScriptEnabled(true);
        webSettings.setDomStorageEnabled(true);

        setWebViewClient(new XsollaWebViewClient());
        setWebChromeClient(new XsollaWebChromeClient(context));
    }
}
