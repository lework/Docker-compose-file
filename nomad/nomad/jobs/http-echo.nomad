job "http-echo" {
  datacenters = ["dc1"]
  type = "system"
  update {
    stagger = "5s"
    max_parallel = 1

  }

  group "http-echo" {
    task "http-echo" {
      driver = "exec"
      config {
        command = "http-echo"
        args = [
          "-listen",
          ":${NOMAD_PORT_http}",
          "-text",
          "hello world",
        ]
      }

      artifact {
        source = "https://github.com/hashicorp/http-echo/releases/download/v0.2.3/http-echo_0.2.3_linux_amd64.zip"
      }
      
      service {
        name = "http-echo"
        tags = ["urlprefix-http-echo.com/"]
        port = "http"
        check {
          name     = "alive"
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }


      resources {
        cpu = 100
        memory = 64
        network {
          mbits = 10
          port "http" {}
        }
      }
    }
  }
}
