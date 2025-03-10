const { app, BrowserWindow, shell } = require('electron');

app.on('ready', () => {
  const mainWindow = new BrowserWindow({
    frame: false,
    transparent: true,
    width: 1360,
    height: 646,
    minWidth: 1360,
    minHeight: 646,
    webPreferences: {
      devTools: true,
      zoomFactor: 1.0,
      scrollBounce: false,
      spellcheck: false,
    },
  })

  // Установить фиксированный фактор зума
  mainWindow.webContents.setZoomFactor(1.0)

  mainWindow.webContents.setWindowOpenHandler(({ url }) => {
    console.info('setWindowOpenHandler', url);
    shell.openExternal(url);

    return { action: "deny" };
  });

  mainWindow.webContents.on('will-navigate', (event, url) => {
    console.info('will-navigate', url);
    if (!url.startsWith('file://')) { // Оставляем внутреннюю навигацию, если она нужна
      event.preventDefault();
      shell.openExternal(url);
    }
  });

  // WRITE YOUR URL HERE
  void mainWindow.loadURL('https://tests-paystation-4.xsolla.site');
})

app.on('certificate-error', (event, webContents, url, error, certificate, callback) => {
  event.preventDefault();
  callback(true);
});
