# UnderFire

Wraps Gracenote's Web API in Ruby goodness. UnderFire provides two interfaces: a client to use from your own programs as well as a command line interface.

## Installation

```ruby
gem install under_fire
```
## Usage

### Command line

UnderFire provides a command line interface (CLI) that makes it easy to explore the Gracenote Web API or combine with other UNIX tools in shell scripts.

Look up the album "Armed Forces":

```
under-fire album -t "Armed Forces"

```

Fetch the image url for "Armed Forces" and save it as "armed-forces.jpg:

```
under-fire album -t "Armed Forces" | grep url | awk '{ print $2 }' | xargs under-fire cover -f "armed-forces.jpg" -u

```


