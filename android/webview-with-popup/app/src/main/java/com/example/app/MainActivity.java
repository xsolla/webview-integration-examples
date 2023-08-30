package com.example.app;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.graphics.Color;
import android.os.Bundle;
import android.webkit.WebSettings;
import android.webkit.WebView;

public class MainActivity extends Activity {
    private WebView mWebView;
    XsollaChildWebView mChildWebView;

    @Override
    @SuppressLint("SetJavaScriptEnabled")
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mWebView = findViewById(R.id.activity_main_webview);
        mChildWebView = findViewById(R.id.childWebView);

        WebView.setWebContentsDebuggingEnabled(true);

        mWebView.setBackgroundColor(Color.TRANSPARENT);

        WebSettings webSettings = mWebView.getSettings();
        webSettings.setBuiltInZoomControls(false);
        webSettings.setUseWideViewPort(true);
        webSettings.setDomStorageEnabled(true);
        webSettings.setLoadWithOverviewMode(true);
        webSettings.setAllowFileAccess(true);
        webSettings.setTextZoom(100);
        webSettings.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
        webSettings.setCacheMode(WebSettings.LOAD_DEFAULT);
        webSettings.setJavaScriptEnabled(true);

        webSettings.setSupportMultipleWindows(true);
        webSettings.setJavaScriptCanOpenWindowsAutomatically(true);

        mWebView.setWebViewClient(new XsollaWebViewClient(this));
        mWebView.setWebChromeClient(new XsollaWebChromeClient(this));

        mWebView.loadUrl("https://secure.xsolla.com/paystation4/?token=bvq6hkyVWq6PIiZgY4MqVeEt7AsziMfT_lc_zh_bg_FFFFFF_tb_3D46F5");
    }
}