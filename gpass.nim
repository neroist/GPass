import std/[
  strutils,
  with,
]

import prologue
from prologue/middlewares/staticfile import staticFileMiddleware

proc home*(ctx: Context) {. async .} =
  await ctx.staticFileResponse("index.html", "public")

proc about*(ctx: Context) {. async .} =
  await ctx.staticFileResponse("about.html", "public")

when isMainModule:
  let 
    #env       = loadPrologueEnv(".env")
    settings  = newSettings(
      appName = "GPass",
      debug   = false,
      port    = Port(8080)
    )

  var app = newApp(settings)

  with app:
    use staticFileMiddleware("./static/")

    get "/", home
    get "/about", about

    run()