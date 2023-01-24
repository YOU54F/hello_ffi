val scala3Version = "3.2.2"

lazy val root = project
  .in(file("."))
  .settings(
    name := "scala",
    version := "0.1.0-SNAPSHOT",

    scalaVersion := scala3Version,

    libraryDependencies += "org.scalameta" %% "munit" % "0.7.29" % Test,
    libraryDependencies += "io.gitlab.mhammons" %% "slinc" % "0.1.1",
        // javaOptions += "--add-modules=jdk.incubator.foreign",
        // javaOptions += "--enable-native-access=ALL-UNNAMED",

        // fork := true,
javaOptions ++= Seq(
  "--add-modules=jdk.incubator.foreign",
  "--enable-native-access=ALL-UNNAMED",
)


    )
    // javaOptions ++= Seq("--add-modules=jdk.incubator.foreign", "--enable-native-access=ALL-UNNAMED")