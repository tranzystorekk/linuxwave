# `linuxwave` 🐧🎵

<p align="center">

![demo](https://github.com/orhun/linuxwave/blob/main/assets/demo.gif)

[![GitHub Release](https://img.shields.io/github/v/release/orhun/linuxwave?style=flat&labelColor=1d1d1d&color=424242&logo=GitHub&logoColor=white)](https://github.com/orhun/linuxwave/releases)
[![Coverage](https://img.shields.io/codecov/c/gh/orhun/linuxwave?style=flat&labelColor=1d1d1d&color=424242&logo=Codecov&logoColor=white)](https://codecov.io/gh/orhun/linuxwave)
[![Continuous Integration](https://img.shields.io/github/actions/workflow/status/orhun/linuxwave/ci.yml?branch=main&style=flat&labelColor=1d1d1d&color=424242&logo=GitHub%20Actions&logoColor=white)](https://github.com/orhun/linuxwave/actions?query=workflow%3A%22Continuous+Integration%22)
[![Continuous Deployment](https://img.shields.io/github/actions/workflow/status/orhun/linuxwave/cd.yml?style=flat&labelColor=1d1d1d&color=424242&logo=GitHub%20Actions&logoColor=white&label=deploy)](https://github.com/orhun/linuxwave/actions?query=workflow%3A%22Continuous+Deployment%22)
[![Docker Builds](https://img.shields.io/github/actions/workflow/status/orhun/linuxwave/docker.yml?style=flat&labelColor=1d1d1d&color=424242&label=docker&logo=Docker&logoColor=white)](https://hub.docker.com/r/orhunp/gpg-tui)
[![Documentation](https://img.shields.io/github/actions/workflow/status/orhun/linuxwave/pages.yml?style=flat&labelColor=1d1d1d&color=424242&logo=Zig&logoColor=white&label=docs)](https://orhun.dev/linuxwave/docs/)

</p>

<details>
  <summary>Table of Contents</summary>

<!-- vim-markdown-toc GFM -->

- [Installation 🤖](#installation-)
  - [Build from source](#build-from-source)
    - [Prerequisites](#prerequisites)
    - [Instructions](#instructions)
  - [Binary releases](#binary-releases)
  - [Docker](#docker)
    - [Images](#images)
    - [Usage](#usage)
    - [Building](#building)
- [Examples 🎵](#examples-)
- [Presets 🎹](#presets-)
- [Usage 📚](#usage-)
  - [`scale`](#scale)
  - [`note`](#note)
  - [`rate`](#rate)
  - [`channels`](#channels)
  - [`format`](#format)
  - [`volume`](#volume)
  - [`duration`](#duration)
  - [`input`](#input)
  - [`output`](#output)
- [Funding 💖](#funding-)
- [Contributing 🌱](#contributing-)
- [License ⚖️](#license-)
- [Copyright ⛓️](#copyright-)

<!-- vim-markdown-toc -->

</details>

## Installation 🤖

### Build from source

#### Prerequisites

- [Zig](https://ziglang.org/download/) (`0.10.1`)

#### Instructions

1. Clone the repository.

```sh
git clone https://github.com/orhun/linuxwave && cd linuxwave/
```

2. Build.

```sh
zig build -Drelease-safe
```

Binary will be located at `zig-out/bin/linuxwave`. You can also run the binary directly via `zig build run`.

If you want to use `linuxwave` in your Zig project as a package, the API documentation is available [here](https://orhun.dev/linuxwave/docs).

### Binary releases

See the available binaries for different targets from the [releases page](https://github.com/orhun/linuxwave/releases). They are automated via [Continuous Deployment](.github/workflows/cd.yml) workflow.

Release tarballs are signed with the following PGP key: [0xC0701E98290D90B8](https://keyserver.ubuntu.com/pks/lookup?search=0xC0701E98290D90B8&op=vindex)

### Docker

#### Images

Docker builds are [automated](./.github/workflows/docker.yml) and images are available in the following registries:

- [Docker Hub](https://hub.docker.com/r/orhunp/linuxwave)
- [GitHub Container Registry](https://github.com/orhun/linuxwave/pkgs/container/linuxwave)

#### Usage

The following command can be used to generate `output.wav` in the current working directory:

```sh
docker run --rm -it -v "$(pwd)":/app "orhunp/linuxwave:${TAG:-latest}"
```

#### Building

Custom Docker images can be built from the [Dockerfile](./Dockerfile):

```sh
docker build -t linuxwave .
```

## Examples 🎵

**Default**: Read random data from `/dev/urandom` to generate a 20-second music composition in the A4 scale and save it to `output.wav`:

```sh
linuxwave
```

To use the A minor blues scale:

```sh
linuxwave -s 0,3,5,6,7,10 -n 220 -o blues.wav
```

Read from an arbitrary file and turn it into a 10-second music composition in the C major scale:

```sh
linuxwave -i build.zig -n 261.63 -d 10 -o music.wav
```

Read from stdin via giving `-` as input:

```sh
cat README.md | linuxwave -i -
```

Write to stdout via giving `-` as output:

```
linuxwave -o - > output.wav
```

## Presets 🎹

Generate a **calming music** with a sample rate of 2000 Hz and a 32-bit little-endian signed integer format:

```sh
linuxwave -r 2000 -f S32_LE -o calm.wav
```

Generate a **chiptune music** with a sample rate of 44100 Hz, stereo (2-channel) output and 8-bit unsigned integer format:

```sh
linuxwave -r 44100 -f U8 -c 2 -o chiptune.wav
```

Generate a **boss stage music** with the volume of 65:

```sh
linuxwave -s 0,7,1 -n 60 -v 65 -o boss.wav
```

Feel free to [submit a pull request](CONTRIBUTING.md) to show off your preset here!

Also, see [this discussion](https://github.com/orhun/linuxwave/discussions/1) for browsing the music generated by our community.

## Usage 📚

```
Options:
  -s, --scale <SCALE>            Sets the musical scale [default: 0,2,3,5,7,8,10,12]
  -n, --note <HZ>                Sets the frequency of the note [default: 440 (A4)]
  -r, --rate <HZ>                Sets the sample rate [default: 24000]
  -c, --channels <NUM>           Sets the number of channels [default: 1]
  -f, --format <FORMAT>          Sets the sample format [default: S16_LE]
  -v, --volume <VOL>             Sets the volume (0-100) [default: 50]
  -d, --duration <SECS>          Sets the duration [default: 20]
  -i, --input <FILE>             Sets the input file [default: /dev/urandom]
  -o, --output <FILE>            Sets the output file [default: output.wav]
  -V, --version                  Display version information.
  -h, --help                     Display this help and exit.
```

### `scale`

Sets the musical scale for the output. It takes a list of [semitones](https://en.wikipedia.org/wiki/Semitone) separated by commas as its argument.

The default value is `0,2,3,5,7,8,10,12`, which represents a major scale starting from C.

Here are other examples:

- A natural minor scale: `0,2,3,5,7,8,10`
- A pentatonic scale starting from G: `7,9,10,12,14`
- A blues scale starting from D: `2,3,4,6,7,10`
- An octatonic scale starting from F#: `6,7,9,10,12,13,15,16`
- Ryukyuan (Okinawa) Japanese scale: `4,5,7,11`

### `note`

The `note` option sets the frequency of the note played. It takes a frequency in Hz as its argument.

The default value is `440`, which represents A4. You can see the frequencies of musical notes [here](https://pages.mtu.edu/~suits/notefreqs.html).

Other examples would be:

- A3 (220 Hz)
- C4 (261.63 Hz)
- G4 (392 Hz)
- A4 (440 Hz) (default)
- E5 (659.26 Hz)

### `rate`

Sets the sample rate for the output in Hertz (Hz).

The default value is `24000`.

### `channels`

Sets the number of audio channels in the output file. It takes an integer as its argument, representing the number of audio channels to generate. The default value is `1`, indicating mono audio.

For stereo audio, set the value to `2`. For multi-channel audio, specify the desired number of channels.

Note that the more audio channels you use, the larger the resulting file size will be.

### `format`

Sets the sample format for the output file. It takes a string representation of the format as its argument.

The default value is `S16_LE`, which represents 16-bit little-endian signed integer.

Possible values are:

- `U8`: Unsigned 8-bit.
- `S16_LE`: Signed 16-bit little-endian.
- `S24_LE`: Signed 24-bit little-endian.
- `S32_LE`: Signed 32-bit little-endian.

### `volume`

Sets the volume of the output file as a percentage from 0 to 100.

The default value is `50`.

### `duration`

Sets the duration of the output file in seconds. It takes a float as its argument.

The default value is `20` seconds.

### `input`

Sets the input file for the music generation. It takes a filename as its argument.

The default value is `/dev/urandom`, which generates random data.

You can provide _any_ type of file for this argument and it will generate music based on the contents of that file.

### `output`

Sets the output file. It takes a filename as its argument.

The default value is `output.wav`.

## Funding 💖

If you find `linuxwave` and/or other projects on my [GitHub profile](https://github.com/orhun) useful, consider supporting me on [GitHub Sponsors](https://github.com/sponsors/orhun) or [becoming a patron](https://www.patreon.com/join/orhunp)!

[![Support me on GitHub Sponsors](https://img.shields.io/github/sponsors/orhun?style=flat&logo=GitHub&labelColor=424242&color=1d1d1d&logoColor=white)](https://github.com/sponsors/orhun)
[![Support me on Patreon](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fshieldsio-patreon.vercel.app%2Fapi%3Fusername%3Dorhunp%26type%3Dpatrons&style=flat&logo=Patreon&labelColor=424242&color=1d1d1d&logoColor=white)](https://patreon.com/join/orhunp)
[![Support me on Patreon](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fshieldsio-patreon.vercel.app%2Fapi%3Fusername%3Dorhunp%26type%3Dpledges&style=flat&logo=Patreon&labelColor=424242&color=1d1d1d&logoColor=white&label=)](https://patreon.com/join/orhunp)

## Contributing 🌱

See our [Contribution Guide](./CONTRIBUTING.md) and please follow the [Code of Conduct](./CODE_OF_CONDUCT.md) in all your interactions with the project.

## License ⚖️

Licensed under [The MIT License](./LICENSE).

## Copyright ⛓️

Copyright © 2023, [Orhun Parmaksız](mailto:orhunparmaksiz@gmail.com)
