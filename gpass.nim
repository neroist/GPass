import jester

import std/[
  strutils,
  os
]

router mainrouter:
  # TODO (hopefully) add a custom 418 error page

  get "/js/script.js":
    resp readFile("./static/js/script.js"), "text/javascript;charset=utf-8"

  get "/css/@filename":
    cond @"filename" in ["style.css", "index.css", "about.css"]

    resp readFile("./static/css/" & @"filename"), "text/css;charset=utf-8"

  get "/icons/favicon.ico":
    resp readFile("./static/icons/favicon.ico"), "image/x-icon"
  get "/icons/github.png":
    resp readFile("./static/icons/github.png"), "image/png"
     
  get "/about":
    sendFile("./public/about.html")

  get "/coffee": # * easter egg
    resp Http418

when isMainModule:
  for dir in ["static", "public"]:
    for file in walkDir(dir):
      setFilePermissions(file.path, getFilePermissions(file.path) + {fpOthersRead})

  var server = initJester(
    mainrouter, 
    newSettings(port = Port(getEnv("PORT", "5000").parseInt))
  )

  server.serve()