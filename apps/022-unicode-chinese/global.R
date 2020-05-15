library(datasets)
rock2 <- rock
names(rock2) <- c("面积", "周长", "形状", "渗透性")

if (!file.exists('wqy-zenhei.ttc')) {
  curl::curl_download(
    'https://github.com/rstudio/shiny-examples/releases/download/v0.10.1/wqy-zenhei.ttc',
    'wqy-zenhei.ttc'
  )
}

sysfonts::font_add("WenQuanYI Zen Hei", "wqy-zenhei.ttc")
showtext::showtext_auto()
onStop(function() { showtext::showtext_auto(FALSE) })
