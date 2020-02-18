# Barracuda Application Server for ESP32

Turn your ESP32 into an advanced Edge Controller and/or IoT Gateway
with the Barracuda Application Server. The included LSP Application
Manager turns the Barracuda Application Server library into an awesome
development tool, thus enabling virtually anyone to program the ESP32
using the super easy to learn Lua Scripting language. Lua is a
beginner-friendly coding language and is in fact promoted as a first
programming language for children.

![Barracuda App Server Edge Controller](https://realtimelogic.com/images/Edge-Controller.png)

The
[Barracuda Application Server](https://realtimelogic.com/products/barracuda-application-server/)
provides a complete high level cloud/IoT/edge development environment
enabling easy, secure, and fast development of embedded software using
Lua/C/C++ as well as providing a rich API for designing modern human
machine interfaces. The Barracuda Application Server is optimized for
embedded use, delivering high performance in a small footprint. The
Barracuda Application Server is the ideal tool for your edge computing
project and lets developers easily design edge related tasks in Lua
and enables easy bridging of cloud/IIoT and edge with its portfolio of
IoT and industrial protocols.

## Why Lua and not Python?

Python may be the king of the desktop, but Lua rocks in embedded
systems. Python's main focus is to be a generic and easy to use
command line scripting language, while Lua is designed to be a C
Library with its main focus on being easy to integrate into a larger
program. Lua is found in many games such as World of Warcraft. Lua has
traditionally been selected when speed and size matters. Developers
generally find Lua to be much faster and less resource hungry than
Python. A developer that knows Python will find it easy to learn Lua
since both languages are similar.

## Why Use Lua in Embedded Systems?

The C/C++ programming languages dominate embedded systems programming,
but developers often run into issues such as buffer overflows, memory
leaks, and other memory corruption errors. With Lua you avoid these
problems, particularly in larger projects where many computer
programmers with varying skills are involved.

Lua abstracts out the details for the underlying microcontroller
hardware. Instead of worrying about the bits and the bytes, a
developer simply accesses methods of a peripheral object to control
the hardware. Hardware control is done via a so called Lua
binding. The abstraction of the hardware layer allows developers to
focus on the application specifics rather than on the workings of the
low-lying hardware. The Lua bindings for the ESP32 has been generated
by [SWIG](http://www.swig.org/Doc4.0/Lua.html#Lua) and closely
resemble the I/O API provided by the
[ESP-IDF C API](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/index.html).

## What is LSP?

Lua Server Pages (LSP) extends Lua with additional features, such as
IoT, making it very easy for any developer regardless of experience to
safely design network/protocol related functionality and high level
logic in Lua. LSP was initially designed for web development, but now
provides much broader support for embedded and network related
programming. We have seen from many successful projects that up to 80%
of a modern embedded system can be implemented using LSP, ensuring
dramatically reduced development time and cost.

## What is the LSP App Manager

The LSP App Manager turns the Barracuda App Server library into an
awesome development tool. Once the development is complete, some minor
changes to the build swaps out the LSP App Manager's Lua code with
your own dedicated LSP/Lua bootloader. See the
[LSP App Manager home page](https://realtimelogic.com/ba/doc/?url=lspappmgr/readme.html)
for details.

## Getting Started

* See the [Barracuda Application Server for ESP32](https://realtimelogic.com/downloads/bas/ESP32/) page for build instructions.
* See the [online Barracuda Application Server Tutorial](https://embedded-app-server.info/) for an introduction to Lua and LSP.
* The sub directory [Lua-Examples](Lua-Examples/README.md) includes ready to use Lua and LSP ESP32 examples.

### Gotchas

We have had some stability issues with the ESP-IDF environment,
particularly the compiler. We had to turn off all optimization and
compile the Barracuda App Server library with the -g flag. The code
was randomly crashing when optimization was applied to the build.

The startup code found in LspAppMgr.c sets up a web server that limits
the number of web server connections to 20; however, this is larger
than the value that can be set using "make menuconfig". We have
manually set the value in the file sdconfig (the file edited using
"make menuconfig") to 32 connections.

CONFIG_LWIP_MAX_ACTIVE_TCP=32

The above is higher than the maximum of 16 connections that can be set
using "make menuconfig". We do not recommend using smaller values as
the web server may sputter with modern browsers if you limit the
number of connections. In addition to the 20 connections that may be
used by the web-server, additional connections may be used as you use
the server to create WebSocket connections, HTTP client connections,
and so on. The lwIP buffers are currently not optimized for the
Barracuda App Server and the server may sometimes appear a bit
sluggish, especially if using the NetIo. Feel free to experiment with
the buffer settings found in the sdconfig file.

The included acme.lsp Lua/LSP example may add an additional two minutes
to the already 2.5 minutes needed for fetching the SSL certificate
from Let's Encrypt. Creating an RSA private key is super heavy duty
and may take up to 120 seconds on the ESP32. Let's Encrypt will
hopefully soon support ECC certificates and you may then switch to
generating an ECC key, which takes less than a seconds.
