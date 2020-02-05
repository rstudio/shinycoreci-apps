# On Windows, set locale to Chinese while this app is running
if (.Platform[['OS.type']] == 'windows') {
  old_locale <- Sys.getlocale()
  Sys.setlocale(category = "LC_ALL", locale = "chs")
  onStop(function() {
    cats <- strsplit(old_locale, ';')[[1]]
    lapply(cats, function(cat) {
      x <- strsplit(cat, '=')[[1]]
      Sys.setlocale(x[1], x[2])
    })
  })
}

library(datasets)
rock2 <- rock
names(rock2) <- c("面积", "周长", "形状", "渗透性")

# Cairo包的PNG设备似乎无法显示中文字符，强制使用R自身的png()设备
options(shiny.usecairo = FALSE)

# 请忽略以下代码，它只是为了解决ShinyApps上没有中文字体的问题
font_home <- function(path = '') file.path('~', '.fonts', path)
if (Sys.info()[['sysname']] == 'Linux' &&
      system('locate wqy-zenhei.ttc') != 0 &&
      !file.exists(font_home('wqy-zenhei.ttc'))) {
  if (!file.exists('wqy-zenhei.ttc'))
    curl::curl_download(
      'https://github.com/rstudio/shiny-examples/releases/download/v0.10.1/wqy-zenhei.ttc',
      'wqy-zenhei.ttc'
    )
  dir.create(font_home())
  file.copy('wqy-zenhei.ttc', font_home())
  system2('fc-cache', paste('-f', font_home()))
}
rm(font_home)


if (.Platform$OS.type == "windows") {
  if (!grepl("Chinese", Sys.getlocale())) {
    warning(
      "You probably want Chinese locale on Windows for this app",
      "to render correctly. See ",
      "https://github.com/rstudio/shiny/issues/1053#issuecomment-167011937"
    )
  }
}
