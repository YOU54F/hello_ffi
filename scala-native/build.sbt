enablePlugins(ScalaNativePlugin)
nativeLinkStubs := true
nativeConfig ~= { c =>
  c.withLinkingOptions(c.linkingOptions ++ Seq("-L"++sys.env.getOrElse("PWD",".")++"/.."))
}