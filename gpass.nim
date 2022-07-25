import std/[
  strutils,
  with,
  os
]

import prologue
import prologue/middlewares/staticfile
#import prologue/middlewares/utils

proc home*(ctx: Context) {. async .} =
  await ctx.staticFileResponse("index.html", "public")

proc about*(ctx: Context) {. async .} =
  await ctx.staticFileResponse("about.html", "public")

when isMainModule:
  let 
    env       = loadPrologueEnv(".env")
    settings  = newSettings(
      appName = env.getOrDefault("name", "GPass"),
      debug   = env.getOrDefault("debug", true),
      port    = Port env.getOrDefault("port", getEnv("PORT", "5000").parseInt) 
    )

  var app = newApp(settings)

  with app:
    #use staticFileMiddleware("./static/", "./public/")
    #use debugRequestMiddleware()

    addRoute "/", home, HttpGet
    addRoute "/about", about, HttpGet

    get "/favicon.ico", redirectTo "./static/favicon.ico"

    run()