package com.example.app;

import android.app.Activity;
import android.net.Uri;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

import androidx.browser.customtabs.CustomTabsIntent;

public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        CustomTabsIntent intent = new CustomTabsIntent.Builder().build();
        EditText textInput = findViewById(R.id.text_url);
        textInput.setText("https://secure.xsolla.com/paystation4?token=YOUR_TOKEN");

        Button customTabBtn = findViewById(R.id.custom_tab_button);
        customTabBtn.setOnClickListener(v -> {
            String url = textInput.getText().toString();
            intent.launchUrl(MainActivity.this, Uri.parse(url));
        });
    }

    ;
}
