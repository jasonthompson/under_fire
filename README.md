# UnderFire

Wraps Gracenote's Web API in Ruby goodness. UnderFire provides two interfaces: a client to use from your own programs as well as a command line interface.

## Installation

```ruby
gem install under_fire
```

## Registration

Before using UnderFire, you need to obtain a `client_id` and `user_id` from Gracenote as described below.

### Obtain client_id

-To obtain a client_id, visit http://developer.gracenote.com and register yourself for a developer account. Once your account is created, you will be prompted to create a new app. Choose a Web API app and, once it's been created, open it from your My Apps page to obtain your "Client ID for Mobile Client, Web API, and eyeQ" (it's the hyphenated one).

-Now on your computer you need to add your `client_id` to your environment. On OSX or Linux you can do this by adding the following line to your `.bashrc`, `.zshrc` or wherever you set your environment variables:

```bash
export GRACENOTE_CLIENT_ID=your-client_id-here

```
After doing this, you'll need to open a new terminal or type the following at the command prompt:

```
source ~/.bashrc

```
Of course, if you use zsh, you would write `source ~/.zshrc` instead.

If you want to test this out, type `echo $GRACENOTE_CLIENT_ID` at your command prompt and it should return the correct value.

### Obtain user_id

-Now you're ready to use UnderFire's register task to obtain your `user_id`. At the command prompt, type:

```
under-fire register `echo $GRACENOTE_CLIENT_ID`

```
Copy your `user_id` from the output and add to your environment by entering the folloing in your `.bashrc` or `.zshrc` as you did with your `client_id` above:

```bash
export GRACENOTE_USER_ID=your-user_id-here

```
again, ensure that your current environment is up to date by opening a new terminal or sourcing the appropriate config file. Now you're ready to get started.

## Usage

### Command line

UnderFire provides a command line interface (CLI) that makes it easy to explore the Gracenote Web API or combine with other UNIX tools in shell scripts. If you followed the registration instructions above, you've already used the CLI to register yourself. Here are some other things you can do:

Look up the album "Armed Forces":

```
under-fire album -t "Armed Forces"

```

Look up "Armed Forces", fetch its cover art, and save it as "armed-forces.jpg in the current folder:

```
under-fire album -t "Armed Forces" | grep url | awk '{ print $2 }' | xargs under-fire cover -f "armed-forces.jpg" -u

```
For more information:

```
under-fire -h

```

### Programming API

If you're familiar with the Gracenote API, you'll note that I have renamed their commands, to make it easier to differentiate between them and to stay with idiomatic Ruby. So, for example, Gracenote's "ALBUM_SEARCH" is called `find_album`.

```ruby

require 'under_fire/client'

# First, get a client instance
client = UnderFire::Client.new

# Search by track title
client.find_album(:track_title => 'Paranoid Android')

# or use either SINGLE_BEST or SINGLE_BEST_COVER
# SINGLE_BEST: returns the single best result as decided by Gracenote.
# SINGLE_BEST_COVER: same as above, but also returns cover URL. Currently this is the default.

album = client.find_album(:track_title => 'Paranoid Android', :mode => 'SINGLE_BEST')

# use query response to fetch the album cover.
client.fetch_cover(album, "OK_Computer_cover.jpg")

# The following searches by Gracenote album id or track id:
album = client.fetch_album(:gn_id => '86372321-2C7F28ADC369EB90E53A7F6CA3A70D56')

# If you want to limit your response to one album, use one of the two modes described above.

```

