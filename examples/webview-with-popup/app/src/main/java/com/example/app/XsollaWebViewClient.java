package com.example.app;

import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.content.Context;
import android.util.Log;

import java.net.URISyntaxException;

class XsollaWebViewClient extends WebViewClient {
    private final Context context;

    public XsollaWebViewClient(Context context) {
        this.context = context;
    }

    @Override
    public boolean shouldOverrideUrlLoading(WebView view, String url) {
        if(url.matches(".+://.*")) {
            try {
                Intent intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME);
                intent.addCategory("android.intent.category.BROWSABLE");
                intent.setComponent(null);
                context.startActivity(intent);
            } catch(URISyntaxException e) {
                Log.e("WebView", "Invalid URL format" + url, e);
            } catch (ActivityNotFoundException e) {
                Log.e("WebView", "No activity found to handle URL: " + url, e);
            }
            return true;
        }

        return false;
    }

    @Override
    public void onPageFinished(WebView view, String url) {
        super.onPageFinished(view, url);
    }
}
