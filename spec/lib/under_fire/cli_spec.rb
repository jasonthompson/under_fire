require_relative '../../spec_helper'
require 'rr'

module UnderFire
  describe CLI do
    before do
      @cli = CLI.new
      @stdout_old = $stdout
      @stdin_old = $stdin
      $stdout = StringIO.new
      $stdin = StringIO.new
#      toc_response = %q{<RESPONSES>
#       <RESPONSE STATUS="OK">
#       <ALBUM><GN_ID>86372321-2C7F28ADC369EB90E53A7F6CA3A70D56</GN_ID>
#       <ARTIST>The Beatles</ARTIST>
#       <TITLE>Help!</TITLE>
#       <PKG_LANG>ENG</PKG_LANG>
#       <GENRE NUM="61364" ID="25332">60&apos;s Rock</GENRE>
#       <TRACK_COUNT>13</TRACK_COUNT>
#       <TRACK>
#          <TRACK_NUM>1</TRACK_NUM>
#          <GN_ID>86372322-05CF584F3265FA67F3E0C18987973C21</GN_ID>
#          <TITLE>Help!</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>2</TRACK_NUM>
#          <GN_ID>86372323-CA2905A4F82908C761E28472D3991EDF</GN_ID>
#          <TITLE>The Night Before</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>3</TRACK_NUM>
#          <GN_ID>86372324-10C31E8C4C6F7B841A045FF6434AB1B0</GN_ID>
#          <TITLE>You&apos;ve Got To Hide Your Love Away</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>4</TRACK_NUM>
#          <GN_ID>86372325-60EE527589C23B2F648156AD400FF857</GN_ID>
#          <TITLE>I Need You</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>5</TRACK_NUM>
#          <GN_ID>86372326-8DAA1AC1B819C66A28E2CD0EAD9D8222</GN_ID>
#          <TITLE>Another Girl</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>6</TRACK_NUM>
#          <GN_ID>86372327-E0DC3EC15ACDFE8E6880329970F82B78</GN_ID>
#          <TITLE>You&apos;re Going To Lose That Girl</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>7</TRACK_NUM>
#          <GN_ID>86372328-CD35818A7400061D8BC4C08D32E0BB38</GN_ID>
#          <TITLE>Ticket To Ride</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>8</TRACK_NUM>
#          <GN_ID>86372329-50EB4C1E500F3F6C895D0F8C48B9663D</GN_ID>
#          <TITLE>Act Naturally</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>9</TRACK_NUM>
#          <GN_ID>86372330-E6FA805C5DBA2E571935B0B8A7978862</GN_ID>
#          <TITLE>It&apos;s Only Love</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>10</TRACK_NUM>
#          <GN_ID>86372331-3F0E4CF181963FB330FF2001775F0FE1</GN_ID>
#          <TITLE>You Like Me Too Much</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>11</TRACK_NUM>
#          <GN_ID>86372332-5744350BE1E7DF380118F4BD93A98AA4</GN_ID>
#          <TITLE>Tell Me What You See</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>12</TRACK_NUM>
#          <GN_ID>86372333-79F674F3FBB538148DEF9ECF56AD4180</GN_ID>
#          <TITLE>I&apos;ve Just Seen A Face</TITLE>
#          </TRACK>
#          <TRACK>
#          <TRACK_NUM>13</TRACK_NUM>
#          <GN_ID>86372334-6EF61C66E4FE46B76C79D697159F0B97</GN_ID>
#          <TITLE>Yesterday</TITLE>
#          </TRACK>
#          <URL TYPE="COVERART" SIZE="MEDIUM">http://web.content.cddbp.net/cds/2.0?id=28088C817AD817CB&amp;client=866304&amp;class=cover&amp;origin=front&amp;size=medium&amp;type=image/jpeg&amp;tag=02-KSYB0rRmIy4UaXsdI4xheDiM0wIntXI9vxq0J9-tYN8uImMSkQ8hg</URL>
#          </ALBUM>
#          </RESPONSE>
#          </RESPONSES>}
#      stub_request(:post, "https://c.web.cddbp.net/webapi/xml/1.0/").
#        with(:body => "<queries><AUTH><CLIENT></CLIENT><USER></USER></AUTH><lang>eng</lang><country>canada</country><app_info>app=\"under-fire 0.6.1\", os=\"x86_64-linux\"</app_info><QUERY cmd=\"ALBUM_TOC\"><MODE>SINGLE_BEST_COVER</MODE><TOC><OFFSETS>150 3432423</OFFSETS></TOC></QUERY></queries>",
#             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/xml', 'User-Agent'=>'Ruby'}).
#        to_return(:status => 200, :body => toc_response, :headers => {})
#    end
#
#    after do
#    $stdout = @stdout_old
#    $stdin = @stdin_old
    end

    describe "#register" do
      it "works" do
        mock($stdout).puts "\nIn order to proceed, please obtain a Gracenote Client ID."
        mock($stdout).puts "\nTo obtain a Client ID:"
        mock($stdout).puts " 1) Register at http://developer.gracenote.com."
        mock($stdout).puts " 2) Click on Add a New App."
        mock($stdout).puts " 3) Obtain your 'Client ID for Mobile Client, Web API, and eyeQ'"
        mock($stdout).puts " from the App Details."
        mock($stdout).puts "Enter your client_id: "
        #mock(UnderFire::Configuration).new('124234325')
        @cli.register
      end
    end
  end
end
