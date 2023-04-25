// build.gradle.kts
plugins {
        kotlin("multiplatform") version "1.8.21"
    }

repositories {
        mavenCentral()
        }


kotlin {
    val hostOs = System.getProperty("os.name")
    val isMingwX64 = hostOs.startsWith("Windows")
    val nativeTarget = when {
        hostOs == "Mac OS X" -> macosArm64("native")
        // hostOs == "Mac OS X" -> macosX64("native")
        hostOs == "Linux" -> linuxX64("native")
        isMingwX64 -> mingwX64("native")
        else -> throw GradleException("Host OS is not supported in Kotlin/Native.")
    }

    nativeTarget.apply {
        compilations.getByName("main") { 
        cinterops {                     
            val pact by creating {
                headers(System.getenv("PWD")+"/../pact.h")
                compilerOpts("-I"+System.getenv("PWD")+"/../"+"-lpact_ffi")
            }    
        }                               
    }                                   
        binaries {
            executable {
                entryPoint = "main"
                linkerOpts("-L"+System.getenv("PWD")+"/../", "-lpact_ffi")

            }
        }
    }
}

tasks.withType<Wrapper> {
    gradleVersion = "7.2"
    distributionType = Wrapper.DistributionType.BIN
}